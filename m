Return-Path: <linux-aspeed+bounces-4198-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AC0CD8CA7
	for <linux-aspeed@archiver.kernel.org>; Mon,  8 Jun 2026 23:51:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZ8254CSqz2ybR;
	Tue, 09 Jun 2026 09:51:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930448;
	cv=none; b=lbAEWa3HM+bIf5kDP3ahaUevsL0r6eid7JxP/gymJoxAR1zFO5ua2pBc8c/WLbe+oDVytl84IhQQex1VZcE4ZPi/ZI4eZUEOk3BA6DkifS9n10gZ8h7Ul3wL6lFkXxCKDPgAgMRilG7iKsvfkIfR3MAboyg0RodIBu5s8gm4dOodc1pHTPA+OCjky/xvRNk+YGtnsv9Hiw2FqoVwb+iQ7emwOmVzL7P47Qom/zGVyX3oqL/rhcdfJyMrWSkwHc6MkTcVnUQJynUxHxIkRKsY6l/bBk7daSkwPGi3R7fnHt/dOizDU7dj5qfmTJg/TXpmD+sULXMdQGbuRrE6pAbdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930448; c=relaxed/relaxed;
	bh=Lm8hR6tmbybGkch7m6sNCS2QOC7j8b++reuYvr6mkvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUBz83ZgdN0mpfn4HObfcLnCHy591mW7IF/KOKLfJ7L18tJrCmruay/zMcMfvmRExKvbl3QBb9hAI3+xQeYJLVXJOKgK+QN46042kLFLpeIZ2i7+GTty0qVwlICHYtrhS0Hp41rk/34X4Xgp3lh3UIZV2/XJzUoPdAmahs7Dp9zFrnb287U+KZsG23WX+0+51qixPJO0+QdZHBRn5EZ27qCY8igCGHIrblHHQwYoGrIVMnS8PDE9Yo0LHt8HZjnq85Pj9zihWaS15Bm1DEG2gGkKPDMp/dBiwmdjyAwibfAlKiyRfZNXJEvG6PqPc//oys5SIjTy/tsTj01112ECYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=XpTso7CF; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=XpTso7CF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYw6Q4fVHz2ytV
	for <linux-aspeed@lists.ozlabs.org>; Tue, 09 Jun 2026 00:54:06 +1000 (AEST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-45fd464d51fso2378685f8f.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 08 Jun 2026 07:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1780930443; x=1781535243; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lm8hR6tmbybGkch7m6sNCS2QOC7j8b++reuYvr6mkvI=;
        b=XpTso7CFGVS/grdSRfOvOGtM4+CtELOKXS46425ZS4L10HduJLQyFSZQvqWh2Qhzme
         H3kltHjwKgemXrfphnktjAQaQHF2vdBw+ESBiQACtRVteh/0orYMBwDO7p9Wow5BZngW
         ML0d3jcFPVK4j4N+KEMNB2l5RFsDsspBNy5CY4jDqoRvUAR4iE//JZeeVQ2uKlao4Q5e
         sDVgZHvWpLJvMAE2WENaxcjDWz95tqiCEuJd1hfijOFSaXxGBXP+Bs+bBQk576sf/S2N
         DG24TSLsRLc6S8ZCrveXVl83IUapSOoTxWWdPc03R1U52XEglU1Ei9VzDEDKAvaSAIOh
         IzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780930443; x=1781535243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lm8hR6tmbybGkch7m6sNCS2QOC7j8b++reuYvr6mkvI=;
        b=ivGDd8XGky9h92qjNmgy5RRfZ2HrgERKSnGWMk0eFw7rBn6kA3uBWtxSz1Gkh9jheP
         gYXQYL2NLajwmj31zi/wh7mXQUsNIoz69/Af0j5mtzXp22zOwI2OoiksFnAX8j/3tWH7
         UUEC03+tPcGCu2XL8VQfro0HOlNpEh9/HMPwMW5B82/GsaYK0/XzDsSpeqJIcdq3Oj/z
         L2Awvu/iHAS9ww+18sWx5IsKvSWm3lYGoxAZ+LThgaJTVpr72j/fQluwpGlSK6TXvPj+
         bqCShgd3QMi43yvBjNHXDg0/m7V2AmGepNPoyI0ZwrMe5F9Oq6bcilLZ315CfDIP9UKv
         S72w==
X-Forwarded-Encrypted: i=1; AFNElJ8RuMXcETh8/QdALdLArCLlBWX8GKtV438JdPDrFLI0uNiv4F3sVtKu9W0xtU24fzl/XRU3FfpUhhDe9cw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx9nyE2QUDY7iAlyI2AdyEjO4clFvGANtgLy6kqmNnBpVPvNu2h
	gRWbsFL5G8qODgVPFAZrlghfFotXqBbYJdDq5iEz/2PodC+eYa68CGMOQqTTuN0O17U=
X-Gm-Gg: Acq92OGWpIpT1s+pnCTAv+qpqH2cf3zQVb+ylLrBG36wt4uETQeEk5ksBeh/AqZhixy
	s69YKl54sZJzxoYzFPUJH30F9lUgnpd6InUYTighn1iihTevdCL+UCjjSumAQXKgltJwYunbKqx
	SncQkTAwX3Ct7t+TbWNSWANrSU/D5VkCuIpjRuFQ9c3exXFcII0ZsL4KcBg5iWKVEp/oBaACcEP
	rGftZ4Y048pfEaKzr5hknSvGA3doQ78R9rSgURlp5TJmG2f+02FP6vjtlcbvuH+BM+ZirQmdFRR
	pzBF8NTfOlRr5sQY1+2+8RVNcBRRG8QKvNvJezsDTWr/FWRLkPVmwK3nbzLaiM0DIra1HUo3g6f
	eHWNMtpsTeXQ0wt0P8XRpVmS+KjGxqBkCLZLcsqW498Jtd0itPwqWsNKNKO3Z/WlsIYbyx1BCJx
	woW8LbOwnD6//MTuwZs80VyvbF70CCt07a62SZV7DaexHVNkfD+FFtl2yQa+05
X-Received: by 2002:adf:e848:0:b0:460:cfc:eb24 with SMTP id ffacd0b85a97d-460304fec2bmr20628232f8f.22.1780930443356;
        Mon, 08 Jun 2026 07:54:03 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f360bd6sm56927851f8f.36.2026.06.08.07.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:54:03 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v2 0/2] soc: aspeed: Add BMC and host driver for PCIe BMC device
Date: Mon,  8 Jun 2026 14:51:21 +0000
Message-ID: <cover.1780929570.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1780409151.git.gregoire.layet@9elements.com>
References: <cover.1780409151.git.gregoire.layet@9elements.com>
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

This is a v2 for upstreaming the VUART over PCIe BMC device driver from the ASPEED kernel SDK (branch master-v6.18) [1].
There are two drivers: a BMC-side driver and a host-side driver.
Together they enable host<->BMC VUART communication via PCIe. 

This v2 narrows down the scope to VUART support only, to address review feedback on v1 [2] 
that the additional subsystems (shared memory, doorbell and mailbox) were software-defined
IPC channels better used with rpmsg or virtio.
Those subsystems are deferred to a separate future series.

VUART data flow and MSI interrupts have been verified working on the test hardware.

Tested on:
BMC:
- Asus IPMI Kommando Card R1.01, AST2600 A3.
- OpenBMC
Host:
- Linux kernel v7.0.0

This v2 only supports AST2600; the AST2700 is untested and not supported by this patch.

Changes since v1 [2]:
 - BMC driver: trimmed down to only SCU and PCIe initialization
 - Host driver: removed shared memory misc device, sysfs doorbell, mailbox setup and message queue handler.
    Driver now only supports VUART registration.
 - Host driver: Fixed cleanup path: removed pci_release_regions() call as there was no matching pci_request_regions call

[1]: https://github.com/AspeedTech-BMC/linux/tree/aspeed-master-v6.18/drivers/soc/aspeed
[2]: https://lore.kernel.org/linux-aspeed/cover.1780409151.git.gregoire.layet@9elements.com/

Grégoire Layet (2):
  soc: aspeed: add BMC-side PCIe BMC device driver
  soc: aspeed: add host-side PCIe BMC device driver

 drivers/soc/aspeed/Kconfig               |  15 ++
 drivers/soc/aspeed/Makefile              |   2 +
 drivers/soc/aspeed/aspeed-bmc-dev.c      | 187 +++++++++++++++++
 drivers/soc/aspeed/aspeed-host-bmc-dev.c | 249 +++++++++++++++++++++++
 4 files changed, 453 insertions(+)
 create mode 100644 drivers/soc/aspeed/aspeed-bmc-dev.c
 create mode 100644 drivers/soc/aspeed/aspeed-host-bmc-dev.c

-- 
2.51.2


