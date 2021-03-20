//
//  ViewController.m
//  Lesson_5.3
//
//  Created by Ekaterina on 20.03.21.
//

#import "ViewController.h"

#define ReuseIdentifier @"reuseIdentifier"

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UISearchResultsUpdating>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray <PhotoImage *> *currentArray;
@property (nonatomic, strong) NSString *photoName;
@property (nonatomic, strong) NSArray *searchArray;
@property (nonatomic, strong) UISearchController *searchController;

- (NSString *)setName;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Images";
    [self configureUI];
    
    self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"camera"] style:UIBarButtonItemStylePlain target:self action:@selector(openImagePicker)];
    
}

- (void)configureUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10.0;
    layout.minimumInteritemSpacing = 10.0;
    layout.itemSize = CGSizeMake(100.0, 100.0);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:ReuseIdentifier];
    [self.view addSubview:_collectionView];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.obscuresBackgroundDuringPresentation = NO;
    self.searchController.searchResultsUpdater = self;
    self.searchArray = [NSArray new];
    self.navigationItem.searchController = self.searchController;
    
    self.currentArray = [[NSMutableArray alloc] init];
}

- (void)openImagePicker {
    UIImagePickerController *controller = [UIImagePickerController new];
    controller.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];

    [picker dismissViewControllerAnimated:YES completion:nil];
    
    PhotoImage *pictureWithName = [[PhotoImage alloc] initWithName:self.setName photo:image];
    [self.currentArray addObject: pictureWithName];
    NSLog(@"%@ - name ", pictureWithName.name);
    [self.collectionView reloadData];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)setName {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Название фото" message:@"Добавьте название вашей фотографии" preferredStyle: UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"название";
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Сохранить" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        UITextField *name = alertController.textFields.firstObject;
        if (![name.text isEqualToString:@""]) {
            self.photoName = name.text;
        }
        else{
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    return self.photoName;
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    if (searchController.searchBar.text) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[cd] %@", searchController.searchBar.text];
        self.searchArray = [self.currentArray filteredArrayUsingPredicate: predicate];
        [self.collectionView reloadData];
    }
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return (self.searchController.isActive && [self.searchArray count] > 0) ? [self.searchArray count] : [self.currentArray count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:   (UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 100);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: ReuseIdentifier  forIndexPath:indexPath];

    PhotoImage *image = (self.searchController.isActive && [self.searchArray count] > 0) ? [self.searchArray objectAtIndex: indexPath.row] : [self.currentArray objectAtIndex: indexPath.row];
    cell.photoImageView.image = image.photo;
    cell.labelName.text = image.name;
    return cell;
}

@end
