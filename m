From: Winiarska, Iwona <iwona.winiarska@intel.com>
Date: Thu, 30 Mar 2023 23:39:12 +0000
Subject: [PATCH] peci: Constify struct peci_controller_ops
In-Reply-To: <20230327224315.11135-1-zev@bewilderbeest.net>
References: <20230327224315.11135-1-zev@bewilderbeest.net>
Message-ID: <f86178f9c276fe2d242d7f99b31c94459d65ed1f.camel@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2023-03-27 at 15:43 -0700, Zev Weiss wrote:
> As with most ops structs, we never modify it at runtime, and keeping
> function pointers in read-only memory is generally a good thing
> security-wise.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Reviewed-by: Iwona Winiarska <iwona.winiarska@intel.com>

Thanks
-Iwona

> ---
> ?drivers/peci/controller/peci-aspeed.c | 2 +-
> ?drivers/peci/core.c?????????????????? | 4 ++--
> ?include/linux/peci.h????????????????? | 4 ++--
> ?3 files changed, 5 insertions(+), 5 deletions(-)
