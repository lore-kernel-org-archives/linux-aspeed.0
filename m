From: Rob Herring <robh@kernel.org>
Date: Tue, 1 Oct 2024 22:48:50 -0500
Subject: [PATCH 2/2] ARM: dts: assign reg to memory nodes
In-Reply-To: <20240930223550.353882-3-rosenp@gmail.com>
References: <20240930223550.353882-1-rosenp@gmail.com> <20240930223550.353882-3-rosenp@gmail.com>
Message-ID: <CAL_JsqKNMhUy3HUAanod27FnJAz35w7FLp7tp0Uo3SeVbG7EGw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 30, 2024 at 5:36?PM Rosen Penev <rosenp@gmail.com> wrote:
>
> Fixes dtc warnings:

Unfortunately we cannot make this change treewide. Any platform that
relies on the ATAGS to DT bootloader support in the kernel
decompressor expects /memory.

Rob
