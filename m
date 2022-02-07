From: Daniel Axtens <dja@axtens.net>
Date: Mon,  7 Feb 2022 17:39:15 +1100
Subject: [PATCH v2 1/3] firmware: Add boot information to sysfs
In-Reply-To: <20220203115344.267159-2-joel@jms.id.au>
References: <20220203115344.267159-2-joel@jms.id.au>
Message-ID: <20220207063915.2079738-1-dja@axtens.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

I really like this design.

Currently on powerpc, a user wanting to check if firmware was
configured to boot with secure boot has to understand both OpenPower
and PowerVM secure boot. On OpenPower they need to check for the
presence of a device-tree property. If they're on PowerVM they need to
decode a different device-tree property and check it's 2 or
greater. Of course, it's not stored as ASCII, it's \x02. And it's
stored big-endian too.

So if powerpc implemented this infrastructure, it would provide users
with one single place to look, and it would represent the value as
ASCII. All very lovely, and it would simplify some scripts enormously.

Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel
