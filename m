From: Jonathan Corbet <corbet@lwn.net>
Date: Thu, 11 Apr 2019 12:43:24 -0600
Subject: [PATCH v2 00/21] Convert hwmon documentation to ReST
In-Reply-To: <cover.1554923967.git.mchehab+samsung@kernel.org>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
Message-ID: <20190411124324.3ed62fad@lwn.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2019 16:22:37 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> This series converts the contents of Documentation/hwmon to ReST
> format.
> 
> PS.: I opted to group the conversion files per groups of maintainer
> set, as, if I were to generate one patch per file, it would give around
> 160 patches.
> 
> I also added those patches to my development tree at:
> 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=hwmon
> 
> If you want to see the results, they're at:
> 	https://www.infradead.org/~mchehab/hwmon/

This set seems generally good and could probably be applied as-is.  But I
have to ask...is there a reason to not take the last step and actually
bring this stuff into the Sphinx doc tree?

We seem to be mostly documenting sysfs files and such.  I am *guessing*
that perhaps the set should move to Documentation/admin-guide/hwmon?  Or
have I misunderstood the intended audience here?

Thanks,

jon
