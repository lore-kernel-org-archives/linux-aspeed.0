From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 29 Apr 2020 11:03:55 +0200
Subject: [PATCH v0 linux master] i2c/busses: Avoid i2c interrupt status
 clear race condition.
In-Reply-To: <56add9c6e6b5410986325a1360466e4b@TWMBX02.aspeed.com>
References: <20200429033737.2781-1-ryan_chen@aspeedtech.com>
 <20200429075357.GA1957@kunai>
 <56add9c6e6b5410986325a1360466e4b@TWMBX02.aspeed.com>
Message-ID: <20200429090355.GA2891@kunai>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> And is there maybe a Fixes: tag for it?
> [Ryan Chen] Yes it is a fix patch.

I meant this (from submitting-patches.rst):

===

If your patch fixes a bug in a specific commit, e.g. you found an issue using
``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
the SHA-1 ID, and the one line summary.  Do not split the tag across multiple
lines, tags are exempt from the "wrap at 75 columns" rule in order to simplify
parsing scripts.  For example::

        Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")

===

So, is it possible to identify a commit introducing the problem?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200429/38bfa40a/attachment.sig>
