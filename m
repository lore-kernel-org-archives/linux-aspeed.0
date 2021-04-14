From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 14 Apr 2021 11:03:58 +0100
Subject: [PATCH v2 2/4] mfd: simple-mfd-i2c: Adds Ampere's Altra SMpro
 support
In-Reply-To: <20210329015238.19474-3-quan@os.amperecomputing.com>
References: <20210329015238.19474-1-quan@os.amperecomputing.com>
 <20210329015238.19474-3-quan@os.amperecomputing.com>
Message-ID: <20210414100358.GL4869@dell>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 29 Mar 2021, Quan Nguyen wrote:

> Adds an MFD driver for SMpro found on the Mt.Jade hardware reference
> platform with Ampere's Altra processor family.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
>  drivers/mfd/Kconfig          | 10 ++++++++++
>  drivers/mfd/simple-mfd-i2c.c |  6 ++++++
>  2 files changed, 16 insertions(+)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [???]
Senior Technical Lead - Developer Services
Linaro.org ? Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
