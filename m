From: Florian Fainelli <florian.fainelli@broadcom.com>
Date: Mon, 26 Feb 2024 10:23:33 -0800
Subject: [PATCH v2 06/14] serial: 8250_bcm7271: Switch to use
 uart_read_port_properties()
In-Reply-To: <20240226142514.1485246-7-andriy.shevchenko@linux.intel.com>
References: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
 <20240226142514.1485246-7-andriy.shevchenko@linux.intel.com>
Message-ID: <b4773e16-6f06-4c62-bd6f-1f2cae7d5e98@broadcom.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2/26/24 06:19, Andy Shevchenko wrote:
> Since we have now a common helper to read port properties
> use it instead of sparse home grown solution.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 4221 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240226/eadcbd86/attachment.p7s>
