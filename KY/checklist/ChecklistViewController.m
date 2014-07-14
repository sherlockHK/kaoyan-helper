//
//  ChecklistsViewController.m
//  KaoYan
//
//  Created by sherlock de Mac mini on 14-5-26.
//  Copyright (c) 2014年 CCNU. All rights reserved.
//

#import "ChecklistViewController.h"
#import "ChecklistItem.h"
#import "Checklist.h"
#import "AppDelegate.h"

@interface ChecklistViewController ()

@end

@implementation ChecklistViewController





- (void)viewDidLoad
{
  [super viewDidLoad];
  self.title = self.checklist.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)save{
    AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appdelegate.dataModelInDelegate  saveChecklists];;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.checklist.items count];
}

- (void)configureCheckmarkForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item
{
  UILabel *label = (UILabel *)[cell viewWithTag:1001];

  if (item.checked) {
    label.text = @"√";
  } else {
    label.text = @"";
  }
    
    label.textColor = self.view.tintColor;
}

- (void)configureTextForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item
{
  UILabel *label = (UILabel *)[cell viewWithTag:1000];

    label.text = [NSString stringWithFormat:@"%@",item.text];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];


  ChecklistItem *item = self.checklist.items[indexPath.row];
    

  [self configureTextForCell:cell withChecklistItem:item];
  [self configureCheckmarkForCell:cell withChecklistItem:item];
	
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    ChecklistItem *item = self.checklist.items[indexPath.row];
  [item toggleChecked];

  [self configureCheckmarkForCell:cell withChecklistItem:item];

    [self save];

  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.checklist.items removeObjectAtIndex:indexPath.row];
    [self save];

  NSArray *indexPaths = @[indexPath];
  [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark delegate

- (void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item
{
    NSInteger newRowIndex = [self.checklist.items count];
    
  [self.checklist.items addObject:item];
  

  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
  NSArray *indexPaths = @[indexPath];
  [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
  [self save];

	
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item
{
    NSInteger index = [self.checklist.items indexOfObject:item];
    
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
  UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
  [self configureTextForCell:cell withChecklistItem:item];

    [self save];

  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"AddItem"]) {
    UINavigationController *navigationController = segue.destinationViewController;
    ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
    controller.delegate = self;
  } else if ([segue.identifier isEqualToString:@"EditItem"]) {
    UINavigationController *navigationController = segue.destinationViewController;
    ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
    controller.delegate = self;

    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
//    controller.itemToEdit = _items[indexPath.row];
      controller.itemToEdit = self.checklist.items[indexPath.row];
      
  }
}

@end
