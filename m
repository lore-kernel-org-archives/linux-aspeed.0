From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 10 Mar 2022 09:02:45 +0100
Subject: [PATCH v2 2/2] ARM: soc: aspeed: Add secure boot controller
 support
In-Reply-To: <20220310000629.119699-3-joel@jms.id.au>
References: <20220310000629.119699-1-joel@jms.id.au>
 <20220310000629.119699-3-joel@jms.id.au>
Message-ID: <CAK8P3a0LKG25Zu1X0m0FmSXpbC6YmWcvyhW1MOcw4XgnazS4sw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 10, 2022 at 1:06 AM Joel Stanley <joel@jms.id.au> wrote:
>
> This reads out the status of the secure boot controller and exposes it
> in debugfs.
>
> An example on a AST2600A3 QEMU model:
>
>  # grep -r . /sys/kernel/debug/aspeed/*
>  /sys/kernel/debug/aspeed/sbc/abr_image:0
>  /sys/kernel/debug/aspeed/sbc/low_security_key:0
>  /sys/kernel/debug/aspeed/sbc/otp_protected:0
>  /sys/kernel/debug/aspeed/sbc/secure_boot:1
>  /sys/kernel/debug/aspeed/sbc/uart_boot:0
>
> On boot the state of the system according to the secure boot controller
> will be printed:
>
>  [    0.037634] AST2600 secure boot enabled
>
> or
>
>  [    0.037935] AST2600 secure boot disabled
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2:
>   - Place files in aspeed/sbc
>   - Check for error when creating directory
>   - Print secure boot message even if debugfs is disabled

The implementation looks fine to me, but I think the changelog needs to
explain why you picked debugfs over a sysfs interface, and how the
interface is going to be used.

As a rule, sysfs interfaces need to be documented and kept stable
so that user space can rely on it, while debugfs interfaces should only
be used for development and never be accessed by applications
that need to work across kernel versions. If no stable user space
is allowed to access these files, what is accessing them?

      Arnd
