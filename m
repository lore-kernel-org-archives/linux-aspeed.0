From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 28 Feb 2022 14:38:58 +0300
Subject: [PATCH 3/6] treewide: fix incorrect use to determine if list is
 empty
In-Reply-To: <20220228110822.491923-4-jakobkoschel@gmail.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-4-jakobkoschel@gmail.com>
Message-ID: <20220228113858.GB2812@kadam>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 28, 2022 at 12:08:19PM +0100, Jakob Koschel wrote:
> The list iterator value will *always* be set by list_for_each_entry().
> It is incorrect to assume that the iterator value will be NULL if the
> list is empty.
> 
> Instead of checking the pointer it should be checked if
> the list is empty.
> In acpi_get_pmu_hw_inf() instead of setting the pointer to NULL
> on the break, it is set to the correct value and leaving it
> NULL if no element was found.
> 
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  arch/powerpc/sysdev/fsl_gtm.c            |  4 ++--
>  drivers/media/pci/saa7134/saa7134-alsa.c |  4 ++--
>  drivers/perf/xgene_pmu.c                 | 13 +++++++------
>  3 files changed, 11 insertions(+), 10 deletions(-)

These are all bug fixes.

1) Send them as 3 separate patches.
2) Add Fixes tags.

regards,
dan carpenter

