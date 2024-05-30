From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 30 May 2024 10:46:52 -0000
Subject: [PATCH v2 02/20] pinctrl: tegra: Use scope based of_node_put()
 cleanups
In-Reply-To: <20240504-pinctrl-cleanup-v2-2-26c5f2dc1181@nxp.com>
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
 <20240504-pinctrl-cleanup-v2-2-26c5f2dc1181@nxp.com>
Message-ID: <D1MX3G6VN849.WKRMI0MU71Q@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat May 4, 2024 at 3:20 PM CEST, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Use scope based of_node_put() cleanup to simplify code.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/pinctrl/tegra/pinctrl-tegra-xusb.c | 7 ++-----
>  drivers/pinctrl/tegra/pinctrl-tegra.c      | 4 +---
>  2 files changed, 3 insertions(+), 8 deletions(-)

Looks good to me:

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240530/c76fe28c/attachment-0001.sig>
