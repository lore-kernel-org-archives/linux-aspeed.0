From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 1 Oct 2024 21:59:58 +0200
Subject: [PATCH 2/2] ARM: dts: assign reg to memory nodes
In-Reply-To: <20240930223550.353882-3-rosenp@gmail.com>
References: <20240930223550.353882-1-rosenp@gmail.com> <20240930223550.353882-3-rosenp@gmail.com>
Message-ID: <CAFBinCB1Rz+C=Tj+RJAL5KZbk9K7cnpF_uR6rKkMeqyCuDBo4A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Rosen,

when you re-send this, please drop the Amlogic files.

On Tue, Oct 1, 2024 at 12:36?AM Rosen Penev <rosenp@gmail.com> wrote:
[...]
>  arch/arm/boot/dts/amlogic/meson6-atv1200.dts                    | 2 +-
This file was dropped with [0]

>  arch/arm/boot/dts/amlogic/meson8-minix-neo-x8.dts               | 2 +-
>  arch/arm/boot/dts/amlogic/meson8b-ec100.dts                     | 2 +-
>  arch/arm/boot/dts/amlogic/meson8b-mxq.dts                       | 2 +-
>  arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts                  | 2 +-
>  arch/arm/boot/dts/amlogic/meson8m2-mxiii-plus.dts               | 2 +-
These got updated with [1]


[0] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git/commit/?h=v6.13/arm-dt&id=e2a3f11ae11c9f9ee780bf49f00a69f12dce3529
[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git/commit/?h=v6.13/arm-dt&id=7947fd2d350e6057e7514459c7ee2db39d1096a2
