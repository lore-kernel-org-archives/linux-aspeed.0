From: Mark Brown <broonie@kernel.org>
Date: Fri, 24 Dec 2021 13:19:43 +0000
Subject: [PATCH v6 5/9] regmap: Introduces regmap lock helpers
In-Reply-To: <20211224041352.29405-6-quan@os.amperecomputing.com>
References: <20211224041352.29405-1-quan@os.amperecomputing.com>
 <20211224041352.29405-6-quan@os.amperecomputing.com>
Message-ID: <YcXI73GKNdx/gvUb@sirena.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Dec 24, 2021 at 11:13:48AM +0700, Quan Nguyen wrote:
> This commit introduces regmap_acquire/release_lock() functions and makes
> them available for drivers that need atomic access of regmap registers

You've not explained what something would need this for and how
it's expected to work - we don't provide unlocked access to the
regmap to client drivers so I don't see how one could safely use
this.  It's unclear to me what this would mean or why it's not
better implemented in the client driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211224/c96c1038/attachment.sig>
