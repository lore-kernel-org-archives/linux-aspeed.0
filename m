From: Waiman Long <longman@redhat.com>
Date: Tue, 30 Jul 2024 14:50:45 -0000
Subject: [PATCH 5/5] locking/ww_mutex/test: add MODULE_DESCRIPTION()
In-Reply-To: <20240730-module_description_orphans-v1-5-7094088076c8@quicinc.com>
References: <20240730-module_description_orphans-v1-0-7094088076c8@quicinc.com>
 <20240730-module_description_orphans-v1-5-7094088076c8@quicinc.com>
Message-ID: <5ecb4ac2-6204-4c20-b98d-9a0e1b33c5f0@redhat.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 7/30/24 10:43, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/test-ww_mutex.o
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>   kernel/locking/test-ww_mutex.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
> index 78719e1ef1b1..10a5736a21c2 100644
> --- a/kernel/locking/test-ww_mutex.c
> +++ b/kernel/locking/test-ww_mutex.c
> @@ -697,3 +697,4 @@ module_exit(test_ww_mutex_exit);
>   
>   MODULE_LICENSE("GPL");
>   MODULE_AUTHOR("Intel Corporation");
> +MODULE_DESCRIPTION("API test facility for ww_mutexes");
Acked-by: Waiman Long <longman@redhat.com>

