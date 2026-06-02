Return-Path: <linux-aspeed+bounces-4164-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E00CD6E5D
	for <linux-aspeed@archiver.kernel.org>; Tue,  2 Jun 2026 23:52:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVSL26pMjz3bpx;
	Wed, 03 Jun 2026 09:52:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780411671;
	cv=none; b=dU9hua+gft7OgIZXXsk8zj8SWkj94wNxrzUykWOG0vePWNMevOZRlsdz8kYVm6vYh4NOBrYNC3jXC05xIuLxU/qZLa+Eni1XYovjEM8ym+WjKNuSpBkBBgf7XsA4Lxw9ngyRFMPdUslXi9pHIo05TISX61js6a407ILy6J6yIM+b+RY6x9uICq88xiQYI22i6NqTUD61gB6v1nhlSP1SZ7w8STXqgoEQrjJloLSfL9REHhpK+LYui1m61ZxJZYobxh5//fHRzap24qum+vA/QptPD1mIZtK2fwVRq66g83Soyt1GFr3hwrjiJWGjRRYQo5Z3ZGiXbTb1xbpFtbISow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780411671; c=relaxed/relaxed;
	bh=Ay/T29lNqSdhRuo/GjV4Eg5RyU5tQbtLVXOjgzh0PCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z//QdKeDyRW4V+keMyRRR1zY8mh/VfqnNO4Ufg7oQkEByIf41RaItIQZc9nJADaC56bY0cjE0UnqN6yd/OpQw06bbDV8Lf1JRpGuk2H1nUL61En5iya92OI20qRXbxXZecnNnYE7Z2nRUOaCXL9lEvLscogn7Y6yAnqUwr7BK5tEzVYmi8BzPFezczaclFe9hQUcwfZ6RBl9MXaI16qZp/BtCxWmVJFk5MU52DpvkLWuHyF4hQzkr8JwVIUDAb440r0N/NC7ch/xsxHzOPBO9iqRP8Nm5xu5WtREDHOKavLne8PAjX4LhM8IoeU3N7RSQsG7mw9cU6MFPOBkQyKw9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=W1TH8Erl; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=W1TH8Erl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVDFx2JFQz2xLk
	for <linux-aspeed@lists.ozlabs.org>; Wed, 03 Jun 2026 00:47:48 +1000 (AEST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-49050bfe053so84808865e9.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 02 Jun 2026 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1780411666; x=1781016466; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ay/T29lNqSdhRuo/GjV4Eg5RyU5tQbtLVXOjgzh0PCM=;
        b=W1TH8Erl6WwYv7RrWBIqq/Ika58xV3NhjOZLMSLO6wHaei9Q15h1wqWxPFdRHz5bkc
         3junKGnU8HPE2wO5y8mBu1MqZtzpAJxzOBmiNRfo3/ngfrcaLcC35OZ7kcTf5kFEOs83
         njj2Kdjws/7zxbhshKeOIrKVkgvAwCVCq+RCb6UG6l2PBfVnW1SAxj8NB4qx8OeiHjfm
         BXE2g+NytzQan64kqSKYabAihFvkZB/jKVwGutr6rM1a2Y3cEhDPJMUfUBlymplTy8F2
         xEJ2EWBQQ7d9ctGlkYxqSm2zr1unGDM1Cb3jmHQpus/ZKFy876LSuR2HoWaE7u3ZuQRI
         /ceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780411666; x=1781016466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ay/T29lNqSdhRuo/GjV4Eg5RyU5tQbtLVXOjgzh0PCM=;
        b=ju4w6yFybr4ZAObn5fSOaQFzgEiSM+lBoNKgbbmtfpNQykK7DeCUl2PEnuavJQvStS
         AT62ilNbaL73okfkzTVoC4CV1rwttWIeOXROOsivgDE6CCo4fG2uiWPc82GsiIZVXiLw
         +P2pCxxTPCqZ4yyG2IPobkyM/KcvSqa6ihhCIERaJvRsHO7Lk/46ymZO2g/N9wrjf29L
         3yeeYI3NEcYNlcLW5HKfPFKBPJkCKsfVUl0NG6Xs1G3lSuwWPPo38FgXsZsZcuMNucDn
         o0+JBJVr2qoM+QMW7nXDQxT2BvHFjV55an7yBUlrHMEr74tFRsKcAcixLi751NCJWzLd
         DHMA==
X-Forwarded-Encrypted: i=1; AFNElJ9vuuybpW2j0cXAgpisRQqB41jK1ufwet/L35656tKy/O5grIaF9Wxy0ygGTkeDqE+3Npx4O+aL5nIZqag=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxbGAmhaAzcPbjOCedIVL3kwsb3SkfwtnsrjZEYfwzB3f3mLc92
	zfH+yVEcToS7iHjAvUaI6h94mgd/9OLJA2oLJqYEgrDp6aOuC3oDYgW9KpU2OAXYuM0=
X-Gm-Gg: Acq92OGEufv5tyUKqGmfUuiKZh2aDbHdfUUxXepzTxYNQZEoa8Wl6LKFCBHyn6DfPj6
	qCMG4zORlIbFY02n9lW5ubpGpxhD5ck61UpzymoQZDrc6mUjkz1UMjel01O/ArpAtqQTd+j19lT
	in6SoJAjfuYp30oWmEsxYzGzMegRGH2y+yTkLPe/DhNnwcZXxEYBZ+38UXurTGyMRmCF0Ahht5G
	d7b2yTNzLjWrQVVjsM4UnA1I5kHBc8wHgGHDT0rzX9D3dulBYSdg3VwEzs+gWXTiLZpViEFgRcU
	LZiZMFFJjQMJYcQi8Knv7O6QQ5EjQA+RGZZjippfBcvqIB5tTZ8wHSfr3tFbpQKME/xlp6eXlSt
	77+3Wzbqbkc8Ruux2Nw6M6e7f2N9gnscyEk6YgvXO9Sj+YRvbjGAxVk3XiG77cGKLHxY/wgdtKI
	glh/zLxBPIi9sTaMupCfY2m0BhasPjyDXu14m7NdP2qvQ4cRGJo7/uWlDB1Wik
X-Received: by 2002:a05:600c:8b32:b0:48a:563c:c8c5 with SMTP id 5b1f17b1804b1-490b5054fccmr908545e9.8.1780411665445;
        Tue, 02 Jun 2026 07:47:45 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e88fdesm74881395e9.14.2026.06.02.07.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:47:45 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v1 0/2] soc: aspeed: Add BMC and host driver for PCIe BMC device
Date: Tue,  2 Jun 2026 16:42:42 +0200
Message-ID: <cover.1780409151.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.51.2
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series upstreams the PCIe BMC device driver from the ASPEED kernel SDK (branch master-v6.18)  [1].
There are two drivers: a BMC-side driver and a host-side driver.
Together they enable host<->BMC communication via PCIe. 
This includes : shared memory, doorbell interrupt communication and two VUARTs.

This driver can be used on AST2600/AST2700 based PCIe extension cards, such as Asus IPMI Kommando Card.
The virtual UART support can be used for Serial over LAN.
The shared memory can be claimed by userspace programs.

Tested on :
BMC :
- Asus IPMI Kommando Card R1.01, AST2600 A3.
- OpenBMC
Host:
- Linux kernel v7.0.0

I tested VUART communication with interrupt.
No driver modifications were required.

Not tested on AST2700.

Provenance:

I did zero modifications to the ASPEED code, this is only an upstream patch.
The driver files match the ASPEED SDK tree at :
  drivers/soc/aspeed/aspeed-bmc-dev.c
    1815546a54f5f89bc9d3bd8f5658f0a573927509 [2]
    "soc: aspeed: remove MMBI implement in host bmc dev"

  drivers/soc/aspeed/aspeed-host-bmc-dev.c
    7217e3c872166d56389a97e1b81996f73a3e76d5 [3]
    "soc: aspeed: remove iounmap"

The driver code build cleanly against Linux 7.0 without any modification.
No fix were required. 
I built both the BMC side and Host side with KCFLAGS=-W and no warning apperead.
Original authors are credited via Signed-off-by in the individual patches.

checkpatch.pl --strict reports 1 warning for BMC side driver
and 2 warnings for host side driver. 
These are unchanged to keep zero diff against the ASPEED SDK tree.
I can clean them in a v2 if needed.

The host side driver had a submission from Ninad Palsule : 
"soc/aspeed: Add host side BMC device driver" in August 2023 [4].
This submission stalled and did not make it into the mainline kernel.
Since then, the host drivers have changed a lot on the ASPEED SDK. 
I decided not to base this patch on Ninad's one 
but rather to simply upstream the new host driver from ASPEED.

[1]: https://github.com/AspeedTech-BMC/linux/tree/aspeed-master-v6.18/drivers/soc/aspeed
[2]: https://github.com/AspeedTech-BMC/linux/commit/1815546a54f5f89bc9d3bd8f5658f0a573927509
[3]: https://github.com/AspeedTech-BMC/linux/commit/7217e3c872166d56389a97e1b81996f73a3e76d5
[4]: https://lore.kernel.org/linux-aspeed/20230821183525.3427144-1-ninad@linux.ibm.com/

Grégoire Layet (2):
  soc: aspeed: add BMC-side PCIe BMC device driver
  soc: aspeed: add host-side PCIe BMC device driver

 drivers/soc/aspeed/Kconfig               |  22 +
 drivers/soc/aspeed/Makefile              |   2 +
 drivers/soc/aspeed/aspeed-bmc-dev.c      | 701 +++++++++++++++++++++++
 drivers/soc/aspeed/aspeed-host-bmc-dev.c | 664 +++++++++++++++++++++
 4 files changed, 1389 insertions(+)
 create mode 100644 drivers/soc/aspeed/aspeed-bmc-dev.c
 create mode 100644 drivers/soc/aspeed/aspeed-host-bmc-dev.c

-- 
2.51.2


