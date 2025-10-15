Return-Path: <linux-aspeed+bounces-2466-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0836CCD193
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Oct 2025 22:36:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cn5YH2pX1z30MZ;
	Thu, 16 Oct 2025 09:36:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760539165;
	cv=none; b=AxNZPkfiN/IL6QLKCHESsUa6QCpBouu05EIMcXWA/sAyubc+N4d9BKxqjgSzLo9FX5JuzgyVr8C24BSdzg8C5JiP+MFgKdoOVapbKQUCKsWN/tZboOj5r8/UBeigSAOpr9Lvnnbn2xnRTeQgBg1ajoCSG2ubn3H+ljZ76mOUadICfIDzCeDck9cCC68Sfj52/4RJpV3sViBNVMZuaxTG41jKhU0IE3jS3o3zUxioe7RvcDOCpgC4bMrLjLKo1A+a3HGSrmp8rCvKP9CDkC5vUOdTNmjKZ6s6Zh7bpDKNKVtfOwfgm3KJUnRdC/ZgAibNd9fkBylrxhjWJFl4J2Jthg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760539165; c=relaxed/relaxed;
	bh=ouWcSpiIf9dLpvZnWLKHc0VRpVvUzoJh4rEYwTYJ/q4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SZQ0lT+gptC4t87Y9ETjW9rSyq6j/wschw4FrVwRP5ZwZ7+qHQejvrXPzuZZHbWdGM/JMERbzSB/uNaHI/3Mhr2RYYGsiGARrd4szs/YcmEblPLVRV9BhM1+uxutHTJnPXmoIvb+3emQftCvpbqNCUU0ZBq1LbzlWYBChPd3GaIk0Rax/tl1LhFjJnoQ2UU40smivmTjSVEkIykH1Slh6TEWNVVzXHTSh6wZpQYWsLf+VmsAGMYlO3EkfZ7oTKsCS+yJVnPZBFwp97DMXb7YmbMyhBoXDVUBJPo6iwEfBNS8H8vJToTv53FZzx+lCk4Fr94cWe4joyoi4fQC4MbR9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LldSY6XF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LldSY6XF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmtyM60zGz3dHf
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Oct 2025 01:39:22 +1100 (AEDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so4107471a12.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Oct 2025 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760539160; x=1761143960; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ouWcSpiIf9dLpvZnWLKHc0VRpVvUzoJh4rEYwTYJ/q4=;
        b=LldSY6XFkm0V25naveiHj7x7eR6cRH2E5E+AfEijBaiyemNjWYE7DwWnPMjRIttbja
         Gi5Xw66mLlF2bFDhPPQeEK+6GjDiaLMzzp0WtdieV2vAZHgZkPe1Kgz91iW4qdRkkzVg
         roSbINPkWzxBaGP96eysVAO3CqWyjGtnmhy9/YRpLy5Tjc371HRwSRji+DpPGldohmlB
         XaNcxBKa+BlR25GWbw+73TIakX9c8gdt7kOAn/kD5hZdlQ8gGMAEx02j6h+l1fUbEFgU
         QDIsvHS8ayJ/L1cDp0IVY0vLoHgaCAGPlTFXk2Xtmt9LukHQsEZ0xeRKK9qw9Yx+jkMG
         Bn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539161; x=1761143961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouWcSpiIf9dLpvZnWLKHc0VRpVvUzoJh4rEYwTYJ/q4=;
        b=p7FOpotL4XMijjpJflYJqTn+7ELqKZ7OA66hk3j7Dh7ASbFUC64ac/+u00sOPuUiM9
         mzeRqlpKt0RFVAZ4ZPKhG0mSxJvoP45NGo0+W+CSaqnAVcufizGYFr5si2AQYqJHUYNX
         gnbr3xZaQ+H9MPdIagRLQyEVpg15jO7Ptv3OgWDKV1V/ev60vwO5COK+tAM9PoaPNcol
         yCnTMujw9+ZzkSsK5z1dRiT3+eQgDxHhycTbIc4ggVbcYbWTJcY/F2Id2zGBHug2jVSw
         GZHSaT42lT+/IHhZkHlbq4fHtlktewz7h+eHReL5sVfhn3OxasCPHxTQKlO4ujJZdvmK
         oU6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU64MHk78IHq9/j3H/4gkA4I8OsoYJzVeosFHIJLi6a7w5x6xh1rxUbyJbYaNRn14SMpPgc41/58Wm08Zs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx+Yxpdw+DO712OCsaLFGAuhhl3bkHHxU0xydl0ZvubWEUw4K55
	3CDQsAdBMtQTOEwT5YltFVv+ZUzlTZTGLRuJMaeEZ429qBuvSLeuUtbe
X-Gm-Gg: ASbGnct1orFIHUZFsCIw2VYFCVXWZf733lLu6a4+49+7rh05QY+g+NDSypOhO/rr79R
	gO4I571E1lpUDa1C9C7zEZBLhxRC8RAqn20SZ+z51a+y/D8jJI45rWtpX8pVVZ+UOyu8Z4US43K
	dnP+lJVUYQ0NR9PkWR6ZTLP5FEcqXkIxVpoZJ0waFxqMHTIYoRZzvcAGIyShYFHI/LCa3uPHUus
	WC4LO4i7MTjSeFjAkGUUjLTalWLB4psTwBifaQ1BUSPkDl+ILInDQtG7Wyq9IUZwkfAFGaGLFD8
	rTJGNbfMN3iM2Be78V7ckPQVTc5Rd34xzrGxEAB8H/2X0AQldEXubCAOMW/NKagaUyVQNmrF/8G
	r8bCtef5DFmuHpiV+ZWiDwltU6Eyj7z4IUyb53GeqGwLAYE5sPpPna1izysDliLPTYj2dHGcQpY
	y/sDm+nEjIg7NydNZ0dgv5MQvl9TB5JxwaiZtmtIWTDE1uxj7Egvmb6gQ29gQC0ay2
X-Google-Smtp-Source: AGHT+IE502KIN4tz1ZiBR1VS+4c/5BDktMXSPvvmFW+gOT8kNcqJukYwWerUdV/VaxRhOB3SKUHsgQ==
X-Received: by 2002:a17:902:f642:b0:250:999f:31c6 with SMTP id d9443c01a7336-290272b4764mr317255775ad.32.1760539160392;
        Wed, 15 Oct 2025 07:39:20 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36738sm199853455ad.87.2025.10.15.07.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:39:20 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/7] Revise Meta Santabarbara devicetree
Date: Wed, 15 Oct 2025 22:38:56 +0800
Message-ID: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
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
Content-Transfer-Encoding: 8bit

Summary:
Revise linux device tree entry related to Meta (Facebook) Santabarbara.

Change log
v3 -> v4:
  - add blank lines between nodes for readability
  - drop changes to already defined LEDs
  - add gpio name debug-card-mux and FM_MAIN_PWREN_RMC_EN_ISO_R
  - enable amd apml interface
  - add eeprom for prot module
v2 -> v3:
  - remove mctp node label
v1 -> v2:
  - add 'bmc_ready_noled' LED and update commit message
  - add sgpio line name for leak detection
v1:
  - add sensor nodes for extension board
  - add mctp node for NIC
  - adjust LED configuration

Fred Chen (7):
  ARM: dts: aspeed: santabarbara: Add blank lines between nodes for
    readability
  ARM: dts: aspeed: santabarbara: Add sensor support for extension
    boards
  ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
  ARM: dts: aspeed: santabarbara: Add bmc_ready_noled Led
  ARM: dts: aspeed: santabarbara: Add gpio line name
  ARM: dts: aspeed: santabarbara: Add AMD APML interface support
  ARM: dts: aspeed: santabarbara: Add eeprom device node for PRoT module

 .../aspeed-bmc-facebook-santabarbara.dts      | 919 +++++++++++++++++-
 1 file changed, 913 insertions(+), 6 deletions(-)

-- 
2.49.0


