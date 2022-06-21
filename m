From: David Gow <davidgow@google.com>
Date: Tue, 21 Jun 2022 16:53:42 +0800
Subject: [PATCH v2 2/5] kunit: flatten kunit_suite*** to kunit_suite** in .kunit_test_suites
In-Reply-To: <20220621085345.603820-1-davidgow@google.com>
References: <20220621085345.603820-1-davidgow@google.com>
Message-ID: <20220621085345.603820-3-davidgow@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Daniel Latypov <dlatypov@google.com>

We currently store kunit suites in the .kunit_test_suites ELF section as
a `struct kunit_suite***` (modulo some `const`s).
For every test file, we store a struct kunit_suite** NULL-terminated array.

This adds quite a bit of complexity to the test filtering code in the
executor.

Instead, let's just make the .kunit_test_suites section contain a single
giant array of struct kunit_suite pointers, which can then be directly
manipulated. This array is not NULL-terminated, and so none of the test
filtering code needs to NULL-terminate anything.

Tested-by: Ma?ra Canal <maira.canal@usp.br>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
Co-developed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220618090310.1174932-3-davidgow at google.com/
- No longer NULL-terminate generated suite_sets
- Add Ma?ra's Tested-by tag.

Changes since RFC:
https://lore.kernel.org/linux-kselftest/20211013191320.2490913-1-dlatypov at google.com/
- Actually flatten the .kunit_test_suites ELF section,
  rather than constructing the flattened version at runtime.
---
 include/kunit/test.h      |  13 ++--
 include/linux/module.h    |   2 +-
 lib/kunit/executor.c      | 115 ++++++++----------------------
 lib/kunit/executor_test.c | 144 +++++++++++---------------------------
 lib/kunit/test.c          |  18 ++---
 5 files changed, 82 insertions(+), 210 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 54306271cfbf..bd8d772979a6 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -237,9 +237,9 @@ size_t kunit_suite_num_test_cases(struct kunit_suite *suite);
 unsigned int kunit_test_case_num(struct kunit_suite *suite,
 				 struct kunit_case *test_case);
 
-int __kunit_test_suites_init(struct kunit_suite * const * const suites);
+int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites);
 
-void __kunit_test_suites_exit(struct kunit_suite **suites);
+void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites);
 
 #if IS_BUILTIN(CONFIG_KUNIT)
 int kunit_run_all_tests(void);
@@ -250,10 +250,10 @@ static inline int kunit_run_all_tests(void)
 }
 #endif /* IS_BUILTIN(CONFIG_KUNIT) */
 
-#define __kunit_test_suites(unique_array, unique_suites, ...)		       \
-	static struct kunit_suite *unique_array[] = { __VA_ARGS__, NULL };     \
-	static struct kunit_suite **unique_suites			       \
-	__used __section(".kunit_test_suites") = unique_array
+#define __kunit_test_suites(unique_array, ...)				       \
+	static struct kunit_suite *unique_array[]			       \
+	__aligned(sizeof(struct kunit_suite *))				       \
+	__used __section(".kunit_test_suites") = { __VA_ARGS__ }
 
 /**
  * kunit_test_suites() - used to register one or more &struct kunit_suite
@@ -271,7 +271,6 @@ static inline int kunit_run_all_tests(void)
  */
 #define kunit_test_suites(__suites...)						\
 	__kunit_test_suites(__UNIQUE_ID(array),				\
-			    __UNIQUE_ID(suites),			\
 			    ##__suites)
 
 #define kunit_test_suite(suite)	kunit_test_suites(&suite)
diff --git a/include/linux/module.h b/include/linux/module.h
index 2490223c975d..518296ea7f73 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -507,7 +507,7 @@ struct module {
 #endif
 #if IS_ENABLED(CONFIG_KUNIT)
 	int num_kunit_suites;
-	struct kunit_suite ***kunit_suites;
+	struct kunit_suite **kunit_suites;
 #endif
 
 
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 96f96e42ce06..2ae9a037a80f 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -9,8 +9,8 @@
  * These symbols point to the .kunit_test_suites section and are defined in
  * include/asm-generic/vmlinux.lds.h, and consequently must be extern.
  */
-extern struct kunit_suite * const * const __kunit_suites_start[];
-extern struct kunit_suite * const * const __kunit_suites_end[];
+extern struct kunit_suite * const __kunit_suites_start[];
+extern struct kunit_suite * const __kunit_suites_end[];
 
 #if IS_BUILTIN(CONFIG_KUNIT)
 
@@ -92,62 +92,18 @@ kunit_filter_tests(struct kunit_suite *const suite, const char *test_glob)
 static char *kunit_shutdown;
 core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
 
-static struct kunit_suite * const *
-kunit_filter_subsuite(struct kunit_suite * const * const subsuite,
-		      struct kunit_test_filter *filter)
-{
-	int i, n = 0;
-	struct kunit_suite **filtered, *filtered_suite;
-
-	n = 0;
-	for (i = 0; subsuite[i]; ++i) {
-		if (glob_match(filter->suite_glob, subsuite[i]->name))
-			++n;
-	}
-
-	if (n == 0)
-		return NULL;
-
-	filtered = kmalloc_array(n + 1, sizeof(*filtered), GFP_KERNEL);
-	if (!filtered)
-		return ERR_PTR(-ENOMEM);
-
-	n = 0;
-	for (i = 0; subsuite[i] != NULL; ++i) {
-		if (!glob_match(filter->suite_glob, subsuite[i]->name))
-			continue;
-		filtered_suite = kunit_filter_tests(subsuite[i], filter->test_glob);
-		if (IS_ERR(filtered_suite))
-			return ERR_CAST(filtered_suite);
-		else if (filtered_suite)
-			filtered[n++] = filtered_suite;
-	}
-	filtered[n] = NULL;
-
-	return filtered;
-}
-
+/* Stores an array of suites, end points one past the end */
 struct suite_set {
-	struct kunit_suite * const * const *start;
-	struct kunit_suite * const * const *end;
+	struct kunit_suite * const *start;
+	struct kunit_suite * const *end;
 };
 
-static void kunit_free_subsuite(struct kunit_suite * const *subsuite)
-{
-	unsigned int i;
-
-	for (i = 0; subsuite[i]; i++)
-		kfree(subsuite[i]);
-
-	kfree(subsuite);
-}
-
 static void kunit_free_suite_set(struct suite_set suite_set)
 {
-	struct kunit_suite * const * const *suites;
+	struct kunit_suite * const *suites;
 
 	for (suites = suite_set.start; suites < suite_set.end; suites++)
-		kunit_free_subsuite(*suites);
+		kfree(*suites);
 	kfree(suite_set.start);
 }
 
@@ -156,7 +112,7 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 					    int *err)
 {
 	int i;
-	struct kunit_suite * const **copy, * const *filtered_subsuite;
+	struct kunit_suite **copy, *filtered_suite;
 	struct suite_set filtered;
 	struct kunit_test_filter filter;
 
@@ -171,14 +127,19 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 
 	kunit_parse_filter_glob(&filter, filter_glob);
 
-	for (i = 0; i < max; ++i) {
-		filtered_subsuite = kunit_filter_subsuite(suite_set->start[i], &filter);
-		if (IS_ERR(filtered_subsuite)) {
-			*err = PTR_ERR(filtered_subsuite);
+	for (i = 0; &suite_set->start[i] != suite_set->end; i++) {
+		if (!glob_match(filter.suite_glob, suite_set->start[i]->name))
+			continue;
+
+		filtered_suite = kunit_filter_tests(suite_set->start[i], filter.test_glob);
+		if (IS_ERR(filtered_suite)) {
+			*err = PTR_ERR(filtered_suite);
 			return filtered;
 		}
-		if (filtered_subsuite)
-			*copy++ = filtered_subsuite;
+		if (!filtered_suite)
+			continue;
+
+		*copy++ = filtered_suite;
 	}
 	filtered.end = copy;
 
@@ -201,52 +162,33 @@ static void kunit_handle_shutdown(void)
 
 }
 
-static void kunit_print_tap_header(struct suite_set *suite_set)
-{
-	struct kunit_suite * const * const *suites, * const *subsuite;
-	int num_of_suites = 0;
-
-	for (suites = suite_set->start; suites < suite_set->end; suites++)
-		for (subsuite = *suites; *subsuite != NULL; subsuite++)
-			num_of_suites++;
-
-	pr_info("TAP version 14\n");
-	pr_info("1..%d\n", num_of_suites);
-}
-
 static void kunit_exec_run_tests(struct suite_set *suite_set)
 {
-	struct kunit_suite * const * const *suites;
+	size_t num_suites = suite_set->end - suite_set->start;
 
-	kunit_print_tap_header(suite_set);
+	pr_info("TAP version 14\n");
+	pr_info("1..%zu\n", num_suites);
 
-	for (suites = suite_set->start; suites < suite_set->end; suites++)
-		__kunit_test_suites_init(*suites);
+	__kunit_test_suites_init(suite_set->start, num_suites);
 }
 
 static void kunit_exec_list_tests(struct suite_set *suite_set)
 {
-	unsigned int i;
-	struct kunit_suite * const * const *suites;
+	struct kunit_suite * const *suites;
 	struct kunit_case *test_case;
 
 	/* Hack: print a tap header so kunit.py can find the start of KUnit output. */
 	pr_info("TAP version 14\n");
 
 	for (suites = suite_set->start; suites < suite_set->end; suites++)
-		for (i = 0; (*suites)[i] != NULL; i++) {
-			kunit_suite_for_each_test_case((*suites)[i], test_case) {
-				pr_info("%s.%s\n", (*suites)[i]->name, test_case->name);
-			}
+		kunit_suite_for_each_test_case((*suites), test_case) {
+			pr_info("%s.%s\n", (*suites)->name, test_case->name);
 		}
 }
 
 int kunit_run_all_tests(void)
 {
-	struct suite_set suite_set = {
-		.start = __kunit_suites_start,
-		.end = __kunit_suites_end,
-	};
+	struct suite_set suite_set = {__kunit_suites_start, __kunit_suites_end};
 	int err = 0;
 
 	if (filter_glob_param) {
@@ -264,11 +206,10 @@ int kunit_run_all_tests(void)
 	else
 		pr_err("kunit executor: unknown action '%s'\n", action_param);
 
-	if (filter_glob_param) { /* a copy was made of each array */
+	if (filter_glob_param) { /* a copy was made of each suite */
 		kunit_free_suite_set(suite_set);
 	}
 
-
 out:
 	kunit_handle_shutdown();
 	return err;
diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index eac6ff480273..0cea31c27b23 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -9,8 +9,6 @@
 #include <kunit/test.h>
 
 static void kfree_at_end(struct kunit *test, const void *to_free);
-static void free_subsuite_at_end(struct kunit *test,
-				 struct kunit_suite *const *to_free);
 static struct kunit_suite *alloc_fake_suite(struct kunit *test,
 					    const char *suite_name,
 					    struct kunit_case *test_cases);
@@ -41,126 +39,80 @@ static void parse_filter_test(struct kunit *test)
 	kfree(filter.test_glob);
 }
 
-static void filter_subsuite_test(struct kunit *test)
+static void filter_suites_test(struct kunit *test)
 {
-	struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
-	struct kunit_suite * const *filtered;
-	struct kunit_test_filter filter = {
-		.suite_glob = "suite2",
-		.test_glob = NULL,
-	};
+	struct kunit_suite *subsuite[3] = {NULL, NULL};
+	struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
+	struct suite_set got;
+	int err = 0;
 
 	subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
 	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
 
 	/* Want: suite1, suite2, NULL -> suite2, NULL */
-	filtered = kunit_filter_subsuite(subsuite, &filter);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered);
-	free_subsuite_at_end(test, filtered);
+	got = kunit_filter_suites(&suite_set, "suite2", &err);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	kfree_at_end(test, got.start);
 
 	/* Validate we just have suite2 */
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]);
-	KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->name, "suite2");
-	KUNIT_EXPECT_FALSE(test, filtered[1]);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
+	KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->name, "suite2");
+
+	/* Contains one element (end is 1 past end) */
+	KUNIT_ASSERT_EQ(test, got.end - got.start, 1);
 }
 
-static void filter_subsuite_test_glob_test(struct kunit *test)
+static void filter_suites_test_glob_test(struct kunit *test)
 {
-	struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
-	struct kunit_suite * const *filtered;
-	struct kunit_test_filter filter = {
-		.suite_glob = "suite2",
-		.test_glob = "test2",
-	};
+	struct kunit_suite *subsuite[3] = {NULL, NULL};
+	struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
+	struct suite_set got;
+	int err = 0;
 
 	subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
 	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
 
 	/* Want: suite1, suite2, NULL -> suite2 (just test1), NULL */
-	filtered = kunit_filter_subsuite(subsuite, &filter);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered);
-	free_subsuite_at_end(test, filtered);
+	got = kunit_filter_suites(&suite_set, "suite2.test2", &err);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	kfree_at_end(test, got.start);
 
 	/* Validate we just have suite2 */
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]);
-	KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->name, "suite2");
-	KUNIT_EXPECT_FALSE(test, filtered[1]);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
+	KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->name, "suite2");
+	KUNIT_ASSERT_EQ(test, got.end - got.start, 1);
 
 	/* Now validate we just have test2 */
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]->test_cases);
-	KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->test_cases[0].name, "test2");
-	KUNIT_EXPECT_FALSE(test, filtered[0]->test_cases[1].name);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
+	KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->test_cases[0].name, "test2");
+	KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].name);
 }
 
-static void filter_subsuite_to_empty_test(struct kunit *test)
+static void filter_suites_to_empty_test(struct kunit *test)
 {
-	struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
-	struct kunit_suite * const *filtered;
-	struct kunit_test_filter filter = {
-		.suite_glob = "not_found",
-		.test_glob = NULL,
-	};
+	struct kunit_suite *subsuite[3] = {NULL, NULL};
+	struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
+	struct suite_set got;
+	int err = 0;
 
 	subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
 	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
 
-	filtered = kunit_filter_subsuite(subsuite, &filter);
-	free_subsuite_at_end(test, filtered); /* just in case */
+	got = kunit_filter_suites(&suite_set, "not_found", &err);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	kfree_at_end(test, got.start); /* just in case */
 
-	KUNIT_EXPECT_FALSE_MSG(test, filtered,
-			       "should be NULL to indicate no match");
-}
-
-static void kfree_subsuites_at_end(struct kunit *test, struct suite_set *suite_set)
-{
-	struct kunit_suite * const * const *suites;
-
-	kfree_at_end(test, suite_set->start);
-	for (suites = suite_set->start; suites < suite_set->end; suites++)
-		free_subsuite_at_end(test, *suites);
-}
-
-static void filter_suites_test(struct kunit *test)
-{
-	/* Suites per-file are stored as a NULL terminated array */
-	struct kunit_suite *subsuites[2][2] = {
-		{NULL, NULL},
-		{NULL, NULL},
-	};
-	/* Match the memory layout of suite_set */
-	struct kunit_suite * const * const suites[2] = {
-		subsuites[0], subsuites[1],
-	};
-
-	const struct suite_set suite_set = {
-		.start = suites,
-		.end = suites + 2,
-	};
-	struct suite_set filtered = {.start = NULL, .end = NULL};
-	int err = 0;
-
-	/* Emulate two files, each having one suite */
-	subsuites[0][0] = alloc_fake_suite(test, "suite0", dummy_test_cases);
-	subsuites[1][0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
-
-	/* Filter out suite1 */
-	filtered = kunit_filter_suites(&suite_set, "suite0", &err);
-	kfree_subsuites_at_end(test, &filtered); /* let us use ASSERTs without leaking */
-	KUNIT_EXPECT_EQ(test, err, 0);
-	KUNIT_ASSERT_EQ(test, filtered.end - filtered.start, (ptrdiff_t)1);
-
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start[0]);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start[0][0]);
-	KUNIT_EXPECT_STREQ(test, (const char *)filtered.start[0][0]->name, "suite0");
+	KUNIT_EXPECT_PTR_EQ_MSG(test, got.start, got.end,
+				"should be empty to indicate no match");
 }
 
 static struct kunit_case executor_test_cases[] = {
 	KUNIT_CASE(parse_filter_test),
-	KUNIT_CASE(filter_subsuite_test),
-	KUNIT_CASE(filter_subsuite_test_glob_test),
-	KUNIT_CASE(filter_subsuite_to_empty_test),
 	KUNIT_CASE(filter_suites_test),
+	KUNIT_CASE(filter_suites_test_glob_test),
+	KUNIT_CASE(filter_suites_to_empty_test),
 	{}
 };
 
@@ -190,20 +142,6 @@ static void kfree_at_end(struct kunit *test, const void *to_free)
 			     (void *)to_free);
 }
 
-static void free_subsuite_res_free(struct kunit_resource *res)
-{
-	kunit_free_subsuite(res->data);
-}
-
-static void free_subsuite_at_end(struct kunit *test,
-				 struct kunit_suite *const *to_free)
-{
-	if (IS_ERR_OR_NULL(to_free))
-		return;
-	kunit_alloc_resource(test, NULL, free_subsuite_res_free,
-			     GFP_KERNEL, (void *)to_free);
-}
-
 static struct kunit_suite *alloc_fake_suite(struct kunit *test,
 					    const char *suite_name,
 					    struct kunit_case *test_cases)
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 3052526b9b89..b6495c7f9a7e 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -582,11 +582,11 @@ static void kunit_init_suite(struct kunit_suite *suite)
 	suite->suite_init_err = 0;
 }
 
-int __kunit_test_suites_init(struct kunit_suite * const * const suites)
+int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites)
 {
 	unsigned int i;
 
-	for (i = 0; suites[i] != NULL; i++) {
+	for (i = 0; i < num_suites; i++) {
 		kunit_init_suite(suites[i]);
 		kunit_run_tests(suites[i]);
 	}
@@ -599,11 +599,11 @@ static void kunit_exit_suite(struct kunit_suite *suite)
 	kunit_debugfs_destroy_suite(suite);
 }
 
-void __kunit_test_suites_exit(struct kunit_suite **suites)
+void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites)
 {
 	unsigned int i;
 
-	for (i = 0; suites[i] != NULL; i++)
+	for (i = 0; i < num_suites; i++)
 		kunit_exit_suite(suites[i]);
 
 	kunit_suite_counter = 1;
@@ -613,18 +613,12 @@ EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
 #ifdef CONFIG_MODULES
 static void kunit_module_init(struct module *mod)
 {
-	unsigned int i;
-
-	for (i = 0; i < mod->num_kunit_suites; i++)
-		__kunit_test_suites_init(mod->kunit_suites[i]);
+	__kunit_test_suites_init(mod->kunit_suites, mod->num_kunit_suites);
 }
 
 static void kunit_module_exit(struct module *mod)
 {
-	unsigned int i;
-
-	for (i = 0; i < mod->num_kunit_suites; i++)
-		__kunit_test_suites_exit(mod->kunit_suites[i]);
+	__kunit_test_suites_exit(mod->kunit_suites, mod->num_kunit_suites);
 }
 
 static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
-- 
2.37.0.rc0.104.g0611611a94-goog

