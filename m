From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 21 Oct 2019 14:23:12 +0200
Subject: [PATCH 1/2] i2c: Aspeed: Add AST2600 compatible
In-Reply-To: <1568392510-866-2-git-send-email-eajames@linux.ibm.com>
References: <1568392510-866-1-git-send-email-eajames@linux.ibm.com>
 <1568392510-866-2-git-send-email-eajames@linux.ibm.com>
Message-ID: <20191021122312.GH1145@ninjato>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 13, 2019 at 11:35:09AM -0500, Eddie James wrote:
> The driver default behavior works with the AST2600. We need a new
> compatible though to make sure the driver doesn't enable AST2400 or
> AST2500 behavior.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20191021/2281d57d/attachment.sig>
