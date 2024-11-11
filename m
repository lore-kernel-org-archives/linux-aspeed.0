Return-Path: <linux-aspeed+bounces-113-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF16FD2E9CC
	for <linux-aspeed@archiver.kernel.org>; Mon, 11 Nov 2024 09:46:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xn4Rx46wvz2yYq;
	Mon, 11 Nov 2024 20:46:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731318365;
	cv=none; b=OaUZMT8PCExDC7LX6nkxFF2H3t9Llwx55wBnaxRTlH0Nbsxe2rIAHkSUvX4AXETzu5It9dCd0VLVEyIzIo72ntMx678TC1bvc/Q7rvlMmCbv1oJj3xTBHUkngBj2fvUWSHV6zDNDRhcAkk4t58+RMPKer85YVSYZv/5lsTzp3Jj/zqVSXf94t6gJp+5cwazVVDXk662ac2dPaKmgCr5cBNZNUv0ZnfmdVqMAivy/MWH6bmzbIO9XQWaqwEidxNbr7XIduzOh7uOwhEfdV8ryKI4MZBBK/7sPpbAMVM3bHF+myOEaEYjitqmqjXSv5OFJKXI5xMehCeN5CQD4yXzljg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731318365; c=relaxed/relaxed;
	bh=Moeko09cNn/tBMWxRyaAP4nMoxzoQVrPZMKwS5ag9u4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SHdVIs1TUeIGYAlYJl83Rd96kbeEGpjWSZymn652kfrh/cYxvNBWOHscFau7e8/ZNS8KW2BDJ/lOZwVoqt0XaSk0yOv6OY5KTBl0W9DH0Ey3TIXX+qm2+DMuk5HLB9sFVlKGGK3Wq3KC2IMThwU2IseCmT5CCVjw7bFjd0BnvcNj5KybB1jvu/stjjAn4XfClvffRRxmFosv2Qush7Er4iu0glgqlPyqK1o1zlgfJavnKlh66TEBdK0ZmADq0Ly0TnHdUrlE5eTnPC277sKiUcTTr0zExXjqDZBHGDOWSiIo9W93Bk2lf8AuqQafvDyVd55J6F8cch5iEv6reDFu8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=g81mM39C; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=g81mM39C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xn4Rw6Vptz2yG9
	for <linux-aspeed@lists.ozlabs.org>; Mon, 11 Nov 2024 20:46:04 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-20ca388d242so43392495ad.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 11 Nov 2024 01:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731318363; x=1731923163; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Moeko09cNn/tBMWxRyaAP4nMoxzoQVrPZMKwS5ag9u4=;
        b=g81mM39CwohB7tg4Lc0KXc0euRCSKaBxQiNHn4HYxFvFg+7owtGUgtAgmRqfZcm8jw
         i2uP9nKrPnB2NF3hut+PTacvuRhvn+CqRLepWeEyD38uXVTwTnlhc/ozTl7DKj+i3K67
         PBMX7TqKy4ByfwQKuGGlelYjlPVSwQjkLlhHKHZVNV3b0ZDEpRU5I89Jr7bKwy+arksf
         Kmix1QCV/QFJEStUG7StlO/YqNKBxUXBb29BRcFEEKuwr8Uk0Z/mJmzA5lz6D0+cWKXA
         F4Jejdsta/y3PyOCob5MQytxC6WqdS+icUHol/21aQTxeTIGW+CQHl6//50NQa/Jz1PM
         mnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731318363; x=1731923163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Moeko09cNn/tBMWxRyaAP4nMoxzoQVrPZMKwS5ag9u4=;
        b=wYlFq9g0GGNj46+KuiVbk6uj7ydFf60b9Nr7q1VngmJzpO9Z6KiftXYcDvw2MhQNMJ
         1HF36M4rWZDhNzQiFKtl5Tf4biJ/Vx4DNBlT3eS8J1tkb0RPc1Rnph13RkAp95fI4PMM
         QWDIoZhnIH+Eg72kGNVNG9BjL/dn59byaLfizsIiscXEXUCZ4Vv2zFjdoNZHcKjNr/Ei
         gZsstlM2tDkEcgC+ThZ2B6c24wWTWJqYFGtiBLpAxTnv8qzLgOyJDb9SzOccE7iXZXB1
         E5L3LsnUju2yJ0AacbSJYmM28Mzs07krslF0/fcesfED/pm7xdBLlWkrFrGo+Xq6IUEx
         g0AQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/HXZwebCPKLkGP5CkyVHWj7g0EbQ8CaxyQa8T3kQLsRunFgqvVQfbR4N9k38svK2QmWzKpaWNegWJJMg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxw3tmHCDkT674+674Vo0HLkblEE/7t4EkJu9PXeX+SJ2ZLD/Up
	k3zazXF5K7oPOevNYFEoL5Tkx60QrLSMBCllLPT7bBx5ZrEioSgd
X-Google-Smtp-Source: AGHT+IESsUyRzaYuCfvnsyqDABRyOahsKXzjXNQUOb+dN8bhzGQnX6lynJCsKMqXKxgd1GTq7ZrUHA==
X-Received: by 2002:a17:902:fc4b:b0:20c:f9ec:cd8a with SMTP id d9443c01a7336-21183d11392mr184701115ad.7.1731318363232;
        Mon, 11 Nov 2024 01:46:03 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc826fsm72248725ad.11.2024.11.11.01.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:46:02 -0800 (PST)
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
Subject: [PATCH v1 4/5] ARM: dts: aspeed: Harma: add e1s power monitor
Date: Mon, 11 Nov 2024 17:43:48 +0800
Message-Id: <20241111094349.2894060-5-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
References: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
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

Add E1S power monitor device.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index ce1731bdc1af..9d7e7208562b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -354,11 +354,22 @@ imux22: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			power-monitor@45 {
+				compatible = "ti,ina230";
+				reg = <0x45>;
+			};
+
 		};
 		imux23: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+
+			power-monitor@45 {
+				compatible = "ti,ina230";
+				reg = <0x45>;
+			};
 		};
 	};
 };
-- 
2.25.1


