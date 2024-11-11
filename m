Return-Path: <linux-aspeed+bounces-109-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80ADDD2E9CC
	for <linux-aspeed@archiver.kernel.org>; Mon, 11 Nov 2024 09:46:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xn4Rq0gy1z2yGq;
	Mon, 11 Nov 2024 20:45:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731318358;
	cv=none; b=hhRJ/VwBdeNYI9Tn1JbM7g8kIdMf6KOqcqN4VfgcktmnPg75d72WNAuAbpUF29UgEi/8f+RHp2gy7y1rDk9yOEo1APRzM/Eczx0t2SqGtQTDJ1s2RnWXKs4S3VtdgZUpfyToM7LLgm7qZp5/MruhbMMfm+Di45VcEJRpmzDzvq8Gb68GscpWET+O+kcUxo8Uh0IJK1OFUe4l8oOBQeEsxzV9Hy3hqNu4HBRaooe3Np5opG/wghgQlKijfuZ4K7NNq05tF4mmW/FLFGSISJ8G/Tmh1CNTuhXbEDFTbnxoWrrvhDg+ZM4WULEa3SfHiM00o6TOZsYgkNt47tOc/ScUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731318358; c=relaxed/relaxed;
	bh=IJ8DZ559nDo5G/ZkZVyMN4vfR4RJ1OGVlWo9rNzGIfU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=aLIDdNtG3YuxcBShdJcwvr4Ju2W/pyUsJBkUKgSsG71qNA/YIbZrfxfNxzvmvVG/npM+NHIVwnG6d6QYwF6MdkebxjAkjNimrd181qKwyu1AtpOogxlIFoEUowTtbSJxf3XZ3SxIZIxCHp7y979boeqx1GBYsA2dkprfiCH7dq7shujSxqE8TqB9w9U22/tpE/Clp8xpkTDcQGyIjnsOdgR98lWj01IIh2EJMXbdXjpFuqY/eNEOpF6mVLED1eKKKMWDCP5chWqTnr6pYfhVokAVyrGFpIzaFMRGlpSDYh/VbWQJlzewfMWTUOyvhSUfpjER8s3UEt0oEmTijtzBig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CXbdPMLN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CXbdPMLN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xn4Rn5LCHz2yF7
	for <linux-aspeed@lists.ozlabs.org>; Mon, 11 Nov 2024 20:45:55 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2110a622d76so38219435ad.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 11 Nov 2024 01:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731318354; x=1731923154; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IJ8DZ559nDo5G/ZkZVyMN4vfR4RJ1OGVlWo9rNzGIfU=;
        b=CXbdPMLNlNxdYcTlnbCi4YYx35qXvm6aq05GrOOSK53cwtFcv+GdquBHwyfZkuZ61T
         qZsW9m5+ETtKcDmQ69rFiOvBeS+1HzQABQGK4jOcs4dhotnp6vxTJbIyZC4hIx/i0hfg
         oMXCU9yW79PAn9Vf7oFH1QASeSGi547ziFzOMGfaX7nkINeAPn5Fxz93p10BseZsY/3f
         kaKrfPYmk7zWI9/CnxSYkkOHj6cNUVdc7gFfaadH5O6kNhq3DwCRakys57JrWN8aE5kM
         1tOrlLSq4RQEF2zP32zeHtX6F81vZyny8BSYEZIibr97xsJtLEijYlzNo49234oAUcH+
         E3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731318354; x=1731923154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJ8DZ559nDo5G/ZkZVyMN4vfR4RJ1OGVlWo9rNzGIfU=;
        b=WYusGJRhXd9RIhRE9H9wJkRM2Zdy3/9S9QnYfZSs949hnycBSUxOIpXaKrb8J2Q57G
         WD1AngnmVdabIJCoOH2Pv35C/VtoAWzpE3vq551pP9sKb5RElMGNJmRFsffsCsAsfeyg
         5ziAyMZ001N8cgiZu46wKj1kQZZizqkuOEdOU4MGXk6BmtC7yLDR6ib0tZgqkA/dPAeb
         LdS6DlJBLsU1UETHr1EJsFhFT+QS4sTeos4skl9jasydowzH+lEVeG08lUNbHLLWZw4G
         1blnDpqtQpe54Q5itQ9dVpsF43/nVZwf4FHDZCcNlyS4OlnLNyUOnvWPQ/vfjuXVqz7T
         iboQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFbNC/78zPWrJBWen2ZkG6HlovTveidU6e7OhVIErL0OVl6D8h0hxTB3jHTMODmgzHwjlLdkdz6tZvz80=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyHK2rqAVHLehF0SXMW2OsPYHnM2DfOiLZ6Dq6kwzNmdixSLgj3
	t1qM8wsoMZ8ynsCy0YZx3S4527C2exOjUm9AXIeMSTl1KFz4QN3l
X-Google-Smtp-Source: AGHT+IGUDV2eKB878pIBUT5cLr6EWiWN+Kf478uOtpN1L7KICE2CM0Gjp1DENkevdsD/kTAUP4K0dw==
X-Received: by 2002:a17:903:1c7:b0:20c:be0e:d47e with SMTP id d9443c01a7336-21183dc7f8dmr128840415ad.56.1731318353680;
        Mon, 11 Nov 2024 01:45:53 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc826fsm72248725ad.11.2024.11.11.01.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:45:53 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Mon, 11 Nov 2024 17:43:44 +0800
Message-Id: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

Base on:
https://github.com/openbmc/linux/blob/dev-6.6/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts

Base on:
https://lore.kernel.org/all/14e1a0f581417d4228aea8c2569598d42b4bd334.camel@codeconstruct.com.au/

v1
  - Patch 0001 - Harma: Revise node name
  - Patch 0002 - Harma: Add retimer device
  - Patch 0003 - Harma: Revise GPIO line name
  - Patch 0004 - Harma: add e1s power monitor
  - Patch 0005 - Harma: fan board io-expander

Peter Yin (5):
  ARM: dts: aspeed: Harma: Revise node name
  ARM: dts: aspeed: Harma: Add retimer device
  ARM: dts: aspeed: Harma: Revise GPIO line name
  ARM: dts: aspeed: Harma: add e1s power monitor
  ARM: dts: aspeed: Harma: fan board io-expander

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 121 ++++++++++++++----
 1 file changed, 97 insertions(+), 24 deletions(-)

-- 
2.25.1


