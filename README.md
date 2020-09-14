# StickyCells
Allows to set several levels of stickied cells

![Farmers Market Finder Demo](Example/output.gif)

## Usage

```swift
import StickyCells
```
You have to use `StickyCellsTableView` and inherit cell class from `StickyCellWith<StickyView: UIView>` where `StickyView` is actual view that will be displayed in table

```swift
class MyStickyCell: StickyCellWith<Label> {}
```

then, in `dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell` method, call `setLevel(_ level: Int?)` on sticky cells

```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
    if let stickyCell = cell as? MyStickyCell {
        stickyCell.stickyView.text = "I'm a sticky cell"
        stickyCell.setLevel(0)
    }
    return cell
}
```

Look at [example app](https://github.com/maximeal10/StickyCells/tree/master/Example) source for details

## Install

[CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

```ruby
target 'YOUR_TARGET' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'StickyCells'

end
```

