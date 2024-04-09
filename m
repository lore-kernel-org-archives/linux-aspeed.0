From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 9 Apr 2024 11:08:10 -0700
Subject: [PATCH v6 4/4] drivers: watchdog: ast2500 and ast2600 support
 bootstatus
In-Reply-To: <47835475-36de-4682-84ae-0163d45d0bac@gmail.com>
References: <20240328022231.3649741-1-peteryin.openbmc@gmail.com>
 <20240328022231.3649741-5-peteryin.openbmc@gmail.com>
 <47835475-36de-4682-84ae-0163d45d0bac@gmail.com>
Message-ID: <01a07242-22ca-4abe-80f9-72ac4de93fb7@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 10, 2024 at 12:28:44AM +0800, PeterYin wrote:
[ ... ]
> 
> Hi Guenter,
>    Could you help me understand the definition of WDIOF_CARDRESET in the
> kernel? If it resets the CPU, should all values be reset to default? Should

Documentation/watchdog/watchdog-api.rst says:

	"Card previously reset the CPU"

This is a bit historic and was probably defined when watchdogs were
not typically integrated. The appropriate description, applied to
current watchdog devices, would be something like "The most recent
reset was triggered by this watchdog".

Not sure I understand "If it resets the CPU...". It doesn't _do_
anything, it just reports if the most recent reset was triggered
by the watchdog.

> we check the POR (RstPwr Power on reset SRST# flag) flag in SCU 0x74
> register bit 0 in ast2600?
> 

Only if it indicates that the most recent reset was triggered by the
watchdog.

Guenter
