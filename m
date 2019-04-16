From: Jonathan Corbet <corbet@lwn.net>
Date: Tue, 16 Apr 2019 14:19:49 -0600
Subject: [PATCH v2 00/21] Convert hwmon documentation to ReST
In-Reply-To: <f900adea-d231-c00d-847c-33e66e79ea30@roeck-us.net>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
 <20190411124324.3ed62fad@lwn.net>
 <20190411174357.251904f5@coco.lan>
 <20190411210731.GA29378@roeck-us.net>
 <20190412100451.6fe49de7@lwn.net>
 <f900adea-d231-c00d-847c-33e66e79ea30@roeck-us.net>
Message-ID: <20190416141949.09b48789@lwn.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2019 20:09:16 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> The big real-world question is: Is the series good enough for you to accept,
> or do you expect some level of user/kernel separation ?

I guess it can go in; it's forward progress, even if it doesn't make the
improvements I would like to see.

The real question, I guess, is who should take it.  I've been seeing a
fair amount of activity on hwmon, so I suspect that the potential for
conflicts is real.  Perhaps things would go smoother if it went through
your tree?

Thanks,

jon
