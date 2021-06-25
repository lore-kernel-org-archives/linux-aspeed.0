From: Wolfram Sang <wsa@kernel.org>
Date: Fri, 25 Jun 2021 17:02:19 +0200
Subject: [PATCH v3 1/7] i2c: i2c-core-smbus: Expose PEC calculate
 function for generic use
In-Reply-To: <20210519074934.20712-2-quan@os.amperecomputing.com>
References: <20210519074934.20712-1-quan@os.amperecomputing.com>
 <20210519074934.20712-2-quan@os.amperecomputing.com>
Message-ID: <YNXv+2SpsTLStsIE@shikoro>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 19, 2021 at 02:49:28PM +0700, Quan Nguyen wrote:
> Expose the PEC calculation i2c_smbus_pec() for generic use.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>

You are the second one who wanted this exported. I agree it makes sense
for slave drivers. So, I'll skip the required user because two are in
flight. Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20210625/99eb8b53/attachment.sig>
