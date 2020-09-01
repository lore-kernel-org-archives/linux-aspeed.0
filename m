From: Borislav Petkov <bp@alien8.de>
Date: Tue, 1 Sep 2020 20:51:36 +0200
Subject: [PATCH 1/2] EDAC/aspeed: Fix handling of platform_get_irq() error
In-Reply-To: <20200827070743.26628-1-krzk@kernel.org>
References: <20200827070743.26628-1-krzk@kernel.org>
Message-ID: <20200901185136.GD8392@zn.tnic>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Aug 27, 2020 at 09:07:42AM +0200, Krzysztof Kozlowski wrote:
> platform_get_irq() returns -ERRNO on error.  In such case comparison
> to 0 would pass the check.
> 
> Fixes: 9b7e6242ee4e ("EDAC, aspeed: Add an Aspeed AST2500 EDAC driver")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/edac/aspeed_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Both applied,
thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
