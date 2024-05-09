document.addEventListener("DOMContentLoaded", function () {
    var checkboxes = document.querySelectorAll('.checkbox-tree input[type="checkbox"]');
    checkboxes.forEach(function (checkbox) {
        checkbox.addEventListener('change', function () {
            var treeBox = this.closest('.tree-box');
            var isChecked = this.checked;
            if (isChecked && treeBox) {
                treeBox.classList.add('tree-selected');
            } else if (!isChecked && treeBox) {
                treeBox.classList.remove('tree-selected');
            }
        });
    });
});

document.addEventListener("DOMContentLoaded", function () {
    var checkAll = document.querySelector('input[name="check-all"]');
    var uncheckAll = document.querySelector('input[name="uncheck-all"]');

    checkAll.addEventListener('change', function () {
        var isChecked = this.checked;
        if (isChecked) {
            checkAll.classList.add('tree-selected');
            uncheckAll.checked = !isChecked;
            var checkboxes = document.querySelectorAll('.checkbox-tree input[type="checkbox"]');
            checkboxes.forEach(function (checkbox) {
                checkbox.checked = isChecked;
                var treeBox = checkbox.closest('.tree-box');
                if (isChecked && treeBox) {
                    treeBox.classList.add('tree-selected');
                }
            });
        }
    });

    uncheckAll.addEventListener('change', function () {
        var isChecked = this.checked;
        if (isChecked) {
            uncheckAll.classList.add('tree-selected');
            checkAll.checked = !isChecked;
            var checkboxes = document.querySelectorAll('.checkbox-tree input[type="checkbox"]');
            checkboxes.forEach(function (checkbox) {
                checkbox.checked = !isChecked;
                var treeBox = checkbox.closest('.tree-box');
                if (isChecked && treeBox) {
                    treeBox.classList.remove('tree-selected');
                }
            });
        }
    });
});