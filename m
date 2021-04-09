From: Arnd Bergmann <arnd@kernel.org>
Date: Fri,  9 Apr 2021 09:18:20 +0200
Subject: [GIT PULL] ARM: aspeed: lpc changes for 5.13
In-Reply-To: <CACPK8Xcb12LsVr7CUaXXjQskKbVjb7x+jgueG1Hik-kBPWtDSg@mail.gmail.com>
References: <CACPK8Xcb12LsVr7CUaXXjQskKbVjb7x+jgueG1Hik-kBPWtDSg@mail.gmail.com>
Message-ID: <161795267844.1750068.14862109207368145425.b4-ty@arndb.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Arnd Bergmann <arnd@arndb.de>

On Fri, 9 Apr 2021 06:29:52 +0000, Joel Stanley wrote:
> This is a pull request containing a slightly messy device tree and
> associated driver changes for the ASPEED systems. It corrects some
> design decisions made when first mainlining support for the BMC
> devices on the LPC bus that have stopped us from being able to write
> drivers for eg. KCS.
> 
> Andrew has worked with Chai-Wei from ASPEED on this process. These set
> of changes have acks from the maintainers, and allow Andrew to go
> ahead with fixing the KCS drivers in the future. The branch should
> apply with no conflicts no matter which order it is merged.
> 
> [...]

Merged into arm/drivers, thanks!

merge commit: d60f314b93b637e9721c406f5a61cf2157e59b48

       Arnd
