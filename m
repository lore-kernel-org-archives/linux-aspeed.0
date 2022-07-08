From: Daniel Latypov <dlatypov@google.com>
Date: Fri, 8 Jul 2022 11:23:08 -0700
Subject: [PATCH v3 1/5] kunit: unify module and builtin suite definitions
In-Reply-To: <20220625050838.1618469-2-davidgow@google.com>
References: <20220625050838.1618469-1-davidgow@google.com> <20220625050838.1618469-2-davidgow@google.com>
Message-ID: <CAGS_qxrGwVL37AOUWCxwx=qg6YvXCDSSu4p_PSt7_87N3RxJZw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 24, 2022 at 10:10 PM David Gow <davidgow@google.com> wrote:
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 8ffcd7de9607..54306271cfbf 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -250,41 +250,8 @@ static inline int kunit_run_all_tests(void)
>  }
>  #endif /* IS_BUILTIN(CONFIG_KUNIT) */
>
> -#ifdef MODULE
> -/**
> - * kunit_test_suites_for_module() - used to register one or more
> - *                      &struct kunit_suite with KUnit.
> - *
> - * @__suites: a statically allocated list of &struct kunit_suite.
> - *
> - * Registers @__suites with the test framework. See &struct kunit_suite for
> - * more information.
> - *
> - * If a test suite is built-in, module_init() gets translated into
> - * an initcall which we don't want as the idea is that for builtins
> - * the executor will manage execution.  So ensure we do not define
> - * module_{init|exit} functions for the builtin case when registering
> - * suites via kunit_test_suites() below.
> - */
> -#define kunit_test_suites_for_module(__suites)                         \

Deleting this bit now causes merge conflicts with Shuah's kunit
branch, due to https://patchwork.kernel.org/project/linux-kselftest/patch/20220702040959.3232874-3-davidgow at google.com/
I.e. We added in a MODULE_INFO(test, "Y") in this to-be-deleted section.

Perhaps something like this would be a fix?

  #ifdef MODULE
  #define _kunit_mark_test_module MODULE_INFO(test, "Y")
  #else
  #define _kunit_mark_test_module
  #endif /* MODULE */

  #define __kunit_test_suites(unique_array, unique_suites, ...)
          \
          _kunit_mark_test_module;
          \
          static struct kunit_suite *unique_array[] = { __VA_ARGS__,
NULL };     \
          static struct kunit_suite **unique_suites
          \
          __used __section(".kunit_test_suites") = unique_array


> -       static int __init kunit_test_suites_init(void)                  \
> -       {                                                               \
> -               return __kunit_test_suites_init(__suites);              \
> -       }                                                               \
> -       module_init(kunit_test_suites_init);                            \
> -                                                                       \
> -       static void __exit kunit_test_suites_exit(void)                 \
> -       {                                                               \
> -               return __kunit_test_suites_exit(__suites);              \
> -       }                                                               \
> -       module_exit(kunit_test_suites_exit)
> -#else
> -#define kunit_test_suites_for_module(__suites)
> -#endif /* MODULE */
> -
>  #define __kunit_test_suites(unique_array, unique_suites, ...)                 \
>         static struct kunit_suite *unique_array[] = { __VA_ARGS__, NULL };     \
> -       kunit_test_suites_for_module(unique_array);                            \
>         static struct kunit_suite **unique_suites                              \
>         __used __section(".kunit_test_suites") = unique_array
>
