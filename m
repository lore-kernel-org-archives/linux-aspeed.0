From: Olof Johansson <olof@lixom.net>
Date: Tue, 25 Jun 2019 04:36:57 -0700
Subject: [GIT PULL] ARM: aspeed: dts changes for 5.3
In-Reply-To: <CACPK8XfMEzqvTGZz7JZxz0XQ0tBHzpJRDxtCEFB-ZzKCyDeuQw@mail.gmail.com>
References: <CACPK8XfMEzqvTGZz7JZxz0XQ0tBHzpJRDxtCEFB-ZzKCyDeuQw@mail.gmail.com>
Message-ID: <20190625113657.uiy7ytcotn57hq3r@localhost>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jun 20, 2019 at 07:34:16AM +0000, Joel Stanley wrote:
> Hello ARM maintainers,
> 
> Here's the ASPEED device tree changes for 5.3. Most of the patches
> have been baking for a number of weeks, with a few late changes added
> in today.
> 
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
> 
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git \
>     tags/aspeed-5.3-devicetree
> 
> for you to fetch changes up to 6084110a0e9c4bff75970f3d68091ceff9e2c2c7:
> 
>   ARM: dts: aspeed: Enable video engine on romulus and wtherspoon
> (2019-06-20 16:37:26 +0930)
> 
> ----------------------------------------------------------------
> ASPEED device tree updates for 5.3
> 
> We have various device tree updates from the OpenBMC project to enable
> bits and pieces in existing systems, notably updates to Google's Zaius.
> 
> There are some AST2500 machines under development:
> 
>   * Lenovo Hr630
>   * IBM Swift
>   * Facebook YAMP
> 
> And some AST2400 machines that have been around but out of tree and have
> now joined the party:
> 
>   * YADRO VESNIN
>   * Microsoft Olympus

Merged, thanks!


-Olof
