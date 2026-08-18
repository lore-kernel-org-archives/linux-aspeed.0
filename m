Return-Path: <linux-aspeed+bounces-4749-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040EAC5DF80
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Aug 2026 10:31:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPQx33wdyz2yFP;
	Tue, 18 Aug 2026 20:31:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787049111;
	cv=none; b=YJiqLjnUPm2wsWCjc82DmpIB5Z/7V8O+eC/yFeCBs9wg1n2itVYwswWqZW+BbGX15oE0OamDdh5cmfE3CHiotvgyG6FPPADmiCnxfLs316qF4cQ6DsclGxf3PHfR1ZimocZXeIf/ZlapXBjvxvPcoLavf6aMcXyEPAE5PwYsaTX45dvodGCDnAcKuhH/mrBtwLPq3KEnCMx5jHvp7Naqvhcd9tTxkdCdADUu46aEm25beNAYnNp67EZ1bAkf1b5J5sWgZ0tJjIZEcSNRKKMh+q3zsGbE2Ai+tpemceChGw6wXWiI2RUGc0SpupjWXIBfa8aIA3sFdJKfqr9GobJxLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787049111; c=relaxed/relaxed;
	bh=iRzYJ7RHlmt5faDVd4SQiUF+QBz3mgu2M1pqY/9IwAk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PTEyQJaDUhmz9TMP+N6YTosiiYBeEoW/PmrH0tsftl+FDkiJtNPsY6kOE/gyV8luYAyBm7baYpXDfSRtM9IWv5ZXLFs1hrTaA+KKOXDLZR7nM93eSH6yruFEkxjpnIrPPmI9pW/I+vxmD4or8FADJ1Lo1ReKZAlXWKWnS2OtBU7svBhSKXyn9HYgeSiGic2qIxD8SIR8ItDAxVpg22Kdi1aQ1rxag2khjZsi5dnTSMS9jXiILLj+WuGDXviD66iJngr4+ImB3PADZlVxHZmRLUw5s4C7f/Yy44m53QkEI6ihbTuDjF/ki7ZVSHy9wd/4+uc0fIW3AS/wpDohj0Gh6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Q/Xfo05I; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Q/Xfo05I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPQwz3zh2z2yCL
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Aug 2026 20:31:46 +1000 (AEST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso44435395e9.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Aug 2026 03:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787049101; x=1787653901; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iRzYJ7RHlmt5faDVd4SQiUF+QBz3mgu2M1pqY/9IwAk=;
        b=Q/Xfo05INzE0NyWeQhbUoOzzAx9E5KRanv1UUnDsu57JXlSC8M+opYw74+6MPhDc8j
         rGiRH/g4oDrkt4UI3/05hAhw+EeVh6vfmFFwq7Mitp4ezbL+gqlXixSmIsgsIsqzv8B9
         lu7USXxbjvDkSKOFE4VNp2XO8ydBJvkwfGpH9DYnromxYxbkrrKqW91OCuddlEN9X3FB
         sabBiqZXvxHCNAObr86qBOkDq6BqI0MtMYwD9fBOe7M1vT75e/DGl+DY6qEdy5JKTlYH
         uslRtKbU0jxDtnTzH66S3AU3Ny5Tk+nykwGd9KEUUZQHSbEEr3WoGZWDpNcfNh3dzUmU
         M4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787049101; x=1787653901;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iRzYJ7RHlmt5faDVd4SQiUF+QBz3mgu2M1pqY/9IwAk=;
        b=M2jK8Y2oLXnezoX58QSZRicruViuSYXeAfd3ocswY/14L3i0TRrcICFtrVf7wXC5ME
         BIfv35tXGLaguyZfoB/RNfJtC5JlsVMquFxXYYeemvWuBLcBnd0BJHW2j+oPohJOZU+4
         YzZQT7ww03cxqt4n3NamYpg55o9uncpkM4PH90dphN8Zi3RKUkUxsFbSBEEz4mib8pOV
         LmfD8t1Gmc0VCty7dSlw/E5cq7PdcMuXHPUd3gse61+wwGNujj7WA5EeaU70iA0dLeW2
         Il0zLcVOidawuY35vH7jvHzOP+SFu3cNzm616SNg4GmA9xxAj1BDxeX7zbWPtl2RK0r4
         FXLw==
X-Forwarded-Encrypted: i=1; AHgh+Ro6tfC/FpspZ/didvRiXsVs8xuBmdZao4ObXLxyIbSYl60OsCh8T+R/umMghLPWaCx1aeb8w/Up4QOlpnE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzZvPC6+h4DQvnbwzeLQH8aquUcq8Xry5DXoS9Pc2akSvOH62rk
	dhUuD+clorJ2SJZY5fgAvGn0l1JL9RLqbfC+AULLfr5bqmei4un4MhKpkKye15aHj18=
X-Gm-Gg: AR+sD11Jm3nN/z59m/dw/DyFTj+tVhp3/fbi6l655UQd2E0hVYOSNrmbGgxrNPFrUSU
	PJmwpy2bDAVgQKx7X2JTDu3OIY0E4LpZPKMbdKW9mSi/xW2qCpiru/dc/VQPd11YqmqqOAUmGTS
	wjllPNhusdjjwAEo0KNVbvCQr9voJ4dH5khcvsXImFS2OqdhU6saOZcumBemE2ZLEOwcWB3EwUN
	n9yP7MDMm/YImucJx8/kms+4fgXYWZZgmY0a1ikWtPQIqIwgzq7a5NCx+phgZjL8XpfSucW6udl
	GPRmqmfBoFzdCK6lC9AOhMwBGKx60aSXZx3CTKI0hJA0HImbYSIAbQ30ubkq2JfFhIpfK9yf58U
	NvPhFGFO0QCRV0nCCdM8klmCREMCwaPq9l7syXKA/betl75BqLuljgzv/Pj2/EVTSx6KuQpgxsj
	lWLwm9BapjrxB7gMXHTYTt2qmD8iF36s5D70VfajsSEOaCHr7D3Z05RWyVh8/Uobv7vWlrrpjI7
	XgwSuq2SANPdLHx9rArk0jLnYFy/KXYwsGMDjvd+/xrJ8sS/JcF0H3rZUXj9N5WsY26xXs=
X-Received: by 2002:a05:600c:6089:b0:499:86ce:465e with SMTP id 5b1f17b1804b1-49987941e38mr561900575e9.4.1787049101182;
        Tue, 18 Aug 2026 03:31:41 -0700 (PDT)
Received: from [127.0.0.2] ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499960988c6sm246025575e9.0.2026.08.18.03.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:31:40 -0700 (PDT)
From: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v6 0/6] soc: aspeed: Add BMC and host driver for PCIe BMC
 device
Date: Tue, 18 Aug 2026 10:29:13 +0000
Message-Id: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPkzhGoC/yXMyw6CMBBG4Vchs3YSyqUBX8W4KO2PjgskM9qYE
 N6dqstvcc5GBhUYnauNFFlMnkuBP1UU72G5gSUVU1M3vh7cwMFWIHFSyVDOntM0jn0bQ+c6RyV
 bFbN8fsvL9W97Tw/E1/dD+34AwrvMHHQAAAA=
X-Change-ID: 20260818-aspeed-driver-v6-db9953ca4141
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>, 
 Tan Siewert <tan.siewert@9elements.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 mfd@lists.linux.dev, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
 yh_chung@aspeedtech.com, ninad@linux.ibm.com, anirudhsriniv@gmail.com, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2

This is the v6 for upstreaming the VUART over PCIe BMC device drivers.

The initial drivers were taken from the ASPEED kernel SDK
(master-v6.18) [1], and have been adapted greatly.

There are two drivers: a BMC-side driver and a host-side driver.
Together they enable host<->BMC VUART communication via PCIe.

The virtual UART is an 8250-compatible register set. It is called
'virtual' because it is internally a simple FIFO.
On the AST2600, two VUARTs can be exposed over PCI via the PCI BMC device.

The host cannot access the BMC's memory. Only the exposed features are
accessible. These are the KCS4 channel and 2 VUARTs. There is also some
mailbox register functionality for a communication between
the host and the BMC. More information can be found here [2].

Changes since v5 [3]:
- Fix small formatting issue in Patch 4's commit message.
- Use static const for MFD cell and uart_port in the mfd driver.

The host driver will performs multiple functions. The AST2600 also
supports LPC over PCI, with a specific KCS channel (KCS4). This host core
driver should also be used to enable the IPMI automatically via this KCS
channel.

Tested:
As with v5, VUART data flow and MSI interrupts have been verified
as working on the test hardware, in both directions and on both VUARTs.
BMC: Asus IPMI Kommando Card R1.01, AST2600 A3 running OpenBMC
Host: Linux kernel v7.0.0

This series only supports the AST2600; the AST2700 is not supported.

The findings regarding the MSI interrupt numbers are explained in the v4
cover letter [4].

As with v3 and v4, I would like to know whether I should add the
'lpc-io-reg' and 'lpc-interrupt' values to the vuart3 and vuart4 nodes
directly in the 'aspeed-g6.dtsi'. The host driver is not capable of
finding the vuart address on its own, so they are hardcoded to 0x3f8 and
0x2f8. It will not work with other addresses, so perhaps they should be
in the .dtsi to ensure the correct configuration for the two vuart over
PCI.

[1]: https://github.com/AspeedTech-BMC/linux/tree/aspeed-master-v6.18/drivers/soc/aspeed
[2]: https://lore.kernel.org/linux-aspeed/CAFi2wKYOAotiezepDqaR5PZDqDaPKKDfAEnpx5EHC0mL39hy6w@mail.gmail.com/
[3]: https://lore.kernel.org/linux-aspeed/cover.1785932211.git.gregoire.layet@9elements.com/
[4]: https://lore.kernel.org/linux-aspeed/cover.1783524645.git.gregoire.layet@9elements.com/

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
Grégoire Layet (6):
      dt-bindings: serial: 8250: aspeed: add ast2600 and aspeed,vuart-over-pci
      serial: 8250_aspeed_vuart: add aspeed,ast2600-vuart compatible string
      serial: 8250_aspeed_vuart: add VUART over PCI
      mfd: aspeed-pci-core: add AST2600 PCIe BMC device driver
      ARM: dts: aspeed: g6: Change vuart compatible string for ast2600
      ARM: dts: aspeed: g6: add aspeed,vuart-over-pci prop to vuart3 and 4

 Documentation/devicetree/bindings/serial/8250.yaml |  42 +++++++-
 MAINTAINERS                                        |   6 ++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |  14 ++-
 drivers/mfd/Kconfig                                |  12 +++
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/aspeed-pci-core.c                      | 115 +++++++++++++++++++++
 drivers/tty/serial/8250/8250_aspeed_vuart.c        |  92 +++++++++++++++++
 7 files changed, 277 insertions(+), 6 deletions(-)
---
base-commit: 6fdec78001b3b94f1b6000bbb2f9ec3498f1c73e
change-id: 20260818-aspeed-driver-v6-db9953ca4141

Best regards,
--  
Grégoire Layet <gregoire.layet@9elements.com>


