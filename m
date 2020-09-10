From: Wolfram Sang <wsa@kernel.org>
Date: Thu, 10 Sep 2020 08:13:59 +0200
Subject: [PATCH v3 2/5] input: misc: Add IBM Operation Panel driver
In-Reply-To: <20200909203059.23427-3-eajames@linux.ibm.com>
References: <20200909203059.23427-1-eajames@linux.ibm.com>
 <20200909203059.23427-3-eajames@linux.ibm.com>
Message-ID: <20200910061359.GA1031@ninjato>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 09, 2020 at 03:30:56PM -0500, Eddie James wrote:
> Add a driver to get the button events from the panel and provide
> them to userspace with the input subsystem. The panel is
> connected with I2C and controls the bus, so the driver registers
> as an I2C slave device.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com> # I2C slave parts

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200910/26171566/attachment.sig>
