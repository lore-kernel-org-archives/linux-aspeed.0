From: Borislav Petkov <bp@alien8.de>
Date: Thu, 19 Dec 2019 07:21:22 +0100
Subject: [PATCH] EDAC/aspeed: Remove unneeded semicolon
In-Reply-To: <1576735835-114453-1-git-send-email-mafeng.ma@huawei.com>
References: <1576735835-114453-1-git-send-email-mafeng.ma@huawei.com>
Message-ID: <20191219062122.GB32039@zn.tnic>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 19, 2019 at 02:10:35PM +0800, Ma Feng wrote:
> Fixes coccicheck warning:
> 
> drivers/edac/aspeed_edac.c:246:2-3: Unneeded semicolon
> drivers/edac/aspeed_edac.c:255:2-3: Unneeded semicolon
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
> ---
>  drivers/edac/aspeed_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

https://lkml.kernel.org/r/1576648806-1114-1-git-send-email-vulab at iscas.ac.cn

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
