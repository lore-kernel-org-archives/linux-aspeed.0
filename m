Return-Path: <linux-aspeed+bounces-3356-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF42D4A5E2
	for <linux-aspeed@archiver.kernel.org>; Fri, 16 Jan 2026 01:59:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsjhS4vH7z2xpl;
	Fri, 16 Jan 2026 12:59:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768528760;
	cv=none; b=mb3RTSjqbcsFlKxFngR0t45Wv1+5u7vEptfMOOEoceOtbDuIJFAlYqlNy8+idbkfcNioHDaqhFupAyyjrbCY3YT1HwEKd7BwpJJO0AArEdmt811koHuATfo9B/NPcVLKFHjXDbH/9KqAfw4YKJWw5n41RH93HJbcAPb5du5kjNUvEta23IWGN0u9L/3yrL8hPReSqDE8E4iZIwy3RWaUFP8V7MnhmCTrTjjWhH9abwI1mTSerf0Vq5b3TJIIc+kVje0WOjL9RzxyNv+wgoIQhoNYMZy3vCxH77mtP+xGQn0GjXFTOoatvbTLbOTMll3GIPCOssBVlRs83czi9uKZng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768528760; c=relaxed/relaxed;
	bh=LkUWOWXKl9G8yXPR1eulHmtakm6kDYpJNDSloOeIcLo=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=CEvBxeQbAgj17i+7QiFa9eDiRh8DIpa24u32azrh9tN3xZVm3F3sxFJzK+7XiYv8Gs9OaVxXA+rg/Ic9qgkK9ZX0T4TUA0VhMCGh3RpS2LqpdH2WGZJfEYTrc/QitwDLOohVyiKB79HSzmSZ44uUC8F4vVWm/VQHgGr7d2/sYfC/jsemZ5rNq5ab06W5YsfumxmYOhX1hjM4HiaPbVQq+/529z0sBV6MQYJs7YThKUcbv76B8bnO7Kh/JC/JxUAk/i0NvvT5DGejqioMZpqlNfqx78P/LAdrEikARKAnvrJ+OSviMrENTGcKysJJqfvT+luPE+3IuIHLulYfnoEuDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=XX0w0J9d; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=XX0w0J9d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsjhR2H8hz2xPL
	for <linux-aspeed@lists.ozlabs.org>; Fri, 16 Jan 2026 12:59:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1768528758;
	bh=LkUWOWXKl9G8yXPR1eulHmtakm6kDYpJNDSloOeIcLo=;
	h=Subject:From:To:Cc:Date;
	b=XX0w0J9deEUHlWxsecb8zMblx8zHhb6/mQaA0xISVC8twjMGp9EpkcE5Ha3fpLzux
	 ei6fWRYJbq+6tAt9zgT6Chx4xlOdd/zrhbQRMvsLeiZj8BorHO2o6WgpGWrKpaT+Lk
	 cDw91RM4RmATTAjlHp6TK8aazLsjiheDhbE8EIJwTKRb9NKjkci7bzkPJz8N/yxU+g
	 7paOXXPsnblM5+98R/lSa/XyallT62f4oH2LpXPSyM15s8BgaojSJENTF/JOmjubZB
	 IxYA78cBL5mzLCvMg0aLeU45/XMG/19I7XcPhHmXcDHwxynMh/Zqaosak20U1pwmoE
	 t1kUznqUKPE4A==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 78B6A64705;
	Fri, 16 Jan 2026 09:59:18 +0800 (AWST)
Message-ID: <c7002883dbeadf44069ef5e8cf573d9f2aefc899.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: second batch of arm devicetree changes for 6.20
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Date: Fri, 16 Jan 2026 12:29:18 +1030
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0

Hello SoC maintainers,

The following changes since commit 459a5aa171c0f13fcd78faa9594dc4aa5a95770b=
:

  ARM: dts: aspeed: bletchley: Fix ADC vref property names (2025-12-17 15:5=
3:31 +1030)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed=
-6.20-devicetree-1

for you to fetch changes up to e600933b6e518397b3f256dddd233e5d8e6cff93:

  ARM: dts: aspeed: ibm: Use non-deprecated AT25 properties (2026-01-08 20:=
04:23 +1030)

----------------------------------------------------------------
aspeed: second batch of arm devicetree changes for 6.20

New platforms:

- Facebook Anacapa

  The Meta Anacapa BMC is the DC-SCM (Data Center Secure Control
  Module) controller for the Meta OCP Open Rack Wide (ORW) compute tray.
  This platform is a key component of the AMD Helios AI rack reference
  design system, designed for next-generation AI workloads.

  The BMC utilizes the Aspeed AST2600 SoC to manage the compute tray, which
  contains up to 4 AMD Instinct MI450 Series GPUs (connected via a Broadcom
  OCP NIC) and host CPUs. Its primary role is to provide essential system
  control, power sequencing, and telemetry reporting for the compute comple=
x
  via the OpenBMC software stack.

  For more detail on the AMD Helios reference design:

  https://www.amd.com/en/blogs/2025/amd-helios-ai-rack-built-on-metas-2025-=
ocp-design.html

- ASRock Rack ALTRAD8

  The ALTRAD8 BMC is an Aspeed AST2500-based BMC for the ASRock Rack
  ALTRAD8UD-1L2T and ALTRAD8UD2-1L2Q boards.

Significant changes:

- Switch IBM FSI CFAM nodes to use non-deprecated AT25 properties

Updated platforms:

- bletchley (Facebook): USB-C tweaks

----------------------------------------------------------------
Cosmo Chou (1):
      ARM: dts: aspeed: bletchley: Remove try-power-role from connectors

Peter Shen (2):
      dt-bindings: arm: aspeed: Add compatible for Facebook Anacapa BMC
      ARM: dts: aspeed: Add Facebook Anacapa platform

Rebecca Cran (2):
      dt-bindings: arm: aspeed: add ASRock Rack ALTRAD8 board
      ARM: dts: aspeed: add device tree for ASRock Rack ALTRAD8 BMC

Rob Herring (Arm) (1):
      ARM: dts: aspeed: ibm: Use non-deprecated AT25 properties

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml   |    2 +
 arch/arm/boot/dts/aspeed/Makefile                          |    2 +
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts     |  637 ++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts   | 1045 ++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts |    6 -
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts        |  128 ++++++--=
----
 arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi             |   64 +++---
 arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi             |   64 +++---
 8 files changed, 1814 insertions(+), 134 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dt=
s


