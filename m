From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 10 Jul 2019 11:17:31 +0200
Subject: [PATCH 00/12] treewide: Fix GENMASK misuses
In-Reply-To: <cover.1562734889.git.joe@perches.com>
 (sfid-20190710_070546_627944_047EEDD0)
References: <cover.1562734889.git.joe@perches.com>
 (sfid-20190710_070546_627944_047EEDD0)
Message-ID: <5fa1fa6998332642c49e2d5209193ffe2713f333.camel@sipsolutions.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2019-07-09 at 22:04 -0700, Joe Perches wrote:
> These GENMASK uses are inverted argument order and the
> actual masks produced are incorrect.  Fix them.
> 
> Add checkpatch tests to help avoid more misuses too.
> 
> Joe Perches (12):
>   checkpatch: Add GENMASK tests

IMHO this doesn't make a lot of sense as a checkpatch test - just throw
in a BUILD_BUG_ON()?

johannes

