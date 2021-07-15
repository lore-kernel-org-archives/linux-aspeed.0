From: Luck, Tony <tony.luck@intel.com>
Date: Thu, 15 Jul 2021 18:29:46 +0000
Subject: [PATCH 01/14] x86/cpu: Move intel-family to arch-independent
 headers
In-Reply-To: <CAPcyv4hxsjKjLkEgGuG6tHvYxUa69315OvhYRORvCtXv6vu2nw@mail.gmail.com>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
 <20210712220447.957418-2-iwona.winiarska@intel.com>
 <32c71687f11fb418dafa45ecf15f7c6b50dd0397.camel@intel.com>
 <218ef97a68491e88d8012799385ee244544a157a.camel@intel.com>
 <CAPcyv4hxsjKjLkEgGuG6tHvYxUa69315OvhYRORvCtXv6vu2nw@mail.gmail.com>
Message-ID: <475c3f70da104d4bac6a902cc41e48d8@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Having 2 potential places for the same definition causes a small
> ongoing maintenance / review burden, so I vote moving the file rather
> than leaving a place holder, but it's ultimately an x86 maintainer
> call.

I thought the patch kept the old file as a stub with just one line:

#include <linux/x86/intel-family.h>

to grab the real data from the new location.  So the information isn't
in two places.

$ git grep -l asm/intel-family.h | wc -l
53

Dang. We seem to love spraying model specific code all over the place :-(

My opinion is to post as Iwona wrote it ... but be prepared for the maintainers
to say "It's only 53 files ... just fix them all"

-Tony

