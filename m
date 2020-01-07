From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Tue, 7 Jan 2020 09:55:37 -0800
Subject: [PATCH 3/3] video: aspeed: Update copyright information
In-Reply-To: <20200107034324.38073-4-joel@jms.id.au>
References: <20200107034324.38073-1-joel@jms.id.au>
 <20200107034324.38073-4-joel@jms.id.au>
Message-ID: <2fdfd5c4-6c0f-313c-297d-fcf51b38adb2@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 1/6/2020 7:43 PM, Joel Stanley wrote:
> Use the preferred form for GPL2+, and add IBM and Intel as the authors.
> The driver was initially upstreamed by Eddie from IBM, and has had major
> contributions from Jae at Intel.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   drivers/media/platform/aspeed-video.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index d70b893fd4cf..71e0dbdb37dc 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -1,4 +1,6 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2020 IBM Corp.
> +// Copyright (c) 2019 Intel Corporation

Acked-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Thanks a lot for adding Intel's copyright.

-Jae

>   #include <linux/atomic.h>
>   #include <linux/bitfield.h>
> 
