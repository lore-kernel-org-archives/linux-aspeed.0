From: Wolfram Sang <wsa@kernel.org>
Date: Sun, 2 Oct 2022 00:55:02 +0200
Subject: [PATCH v9 3/3] i2c: aspeed: Assert NAK when slave is busy
In-Reply-To: <20220929080326.752907-4-quan@os.amperecomputing.com>
References: <20220929080326.752907-1-quan@os.amperecomputing.com>
 <20220929080326.752907-4-quan@os.amperecomputing.com>
Message-ID: <YzjFRrCRZBAaSRBL@shikoro>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> +		if (ret == -EBUSY)

Since we documented this:

"+  'ret': 0 if the backend is ready, otherwise some errno"

the code above should be '(ret < 0)'

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20221002/06692e4b/attachment.sig>
