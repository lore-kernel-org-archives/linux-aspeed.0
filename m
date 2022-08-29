From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 29 Aug 2022 11:49:30 +0100
Subject: [PATCH] crypto: aspeed: fix build module error
In-Reply-To: <20220829072035.1539399-1-neal_liu@aspeedtech.com>
References: <20220829072035.1539399-1-neal_liu@aspeedtech.com>
Message-ID: <CADVatmNzj2XAPL5bA5JKW9gbMM7bUoOOqh=9+Fh4v79Z-=BjgQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 29, 2022 at 8:42 AM Neal Liu <neal_liu@aspeedtech.com> wrote:
>
> If CONFIG_MODULES=y and CONFIG_CRYPTO_DEV_ASPEED=m,
> build modpost would be failed.
>
> Error messages:
>   ERROR: modpost: "aspeed_register_hace_hash_algs"
>   [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
>   ERROR: modpost: "aspeed_unregister_hace_hash_algs"
>   [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
>
> Change build sequence to fix this.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

-- 
Regards
Sudip
