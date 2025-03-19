Return-Path: <linux-aspeed+bounces-1064-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD54C35FFC
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Mar 2025 16:49:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHvnv4fNTz2yf9;
	Thu, 20 Mar 2025 03:49:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742402995;
	cv=none; b=IhT8RMy0Tbop3Rr6r8irqVqFaxJh1ciL0T6A4TqfRDBGwNUkGzT4SSt6neBQ20qptl1qD/RgvyDiTigqxX/AvY3gZl7VTox/zLVMwTqsp5qVCAf9X2pwt8KRPZHa3l+e0TcKmmG6LekICZsARiZme1iSONMa4ADZeMlvGmrKP0jR8z3thzdUNbyU7bo3QB9zKHTRj1D75MFcou/8EU0L2Ih4bs9M1j1TdYtDA9ZZ8TyTxtWdLYjPVripPaBZDqrIkBpQlXWn+UYXlfrOz9TMlIqDsz+VyicqKRQH5XzoXB2hsIOqJtwnynKvFMVWS9NxlggqmWJeIg3fdnSn64zsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742402995; c=relaxed/relaxed;
	bh=otdawq32D6/5bERzoT5Rk23HrOvjEoRzM0gTHt/o2Nk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TCS8qeKISCvdV6NNJC1d+pnMDWXWL52x82sKb4mfG/tkXh7+MPqfTfTxgDKST762ug6i7X/IyhD1VWeZ38I9BCYEXnPg5fov5dUohoIYwANkMbWSeIevyKqWwsjK4cJLccc+4hnimeXY66JyEO6SeFCaVF77E+OOtw78kDkBQP62e7zLoIVTykkpstgFEZnlL3j3hh10J10I8gAdvxHijCLOfFxFpoj5xzWfYUhDMmWb0QP0HCbiJFH4d/xf0D6oCeyd6HZZ5QNP2cFTRwXzQKaKdwh3K8ZEbyVY3MNG7a+5AcxVc/bJ4ykqpq8eBE5lTWpvOn3N7PjqVt3TZPlD5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QnUtgigw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QnUtgigw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHvnt38Cvz2xCd
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Mar 2025 03:49:54 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2255003f4c6so131324075ad.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Mar 2025 09:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742402991; x=1743007791; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=otdawq32D6/5bERzoT5Rk23HrOvjEoRzM0gTHt/o2Nk=;
        b=QnUtgigw1jvrQJoiHEH/XubWx9UDOtgLSwD4cuzZAx6Vwp4NnbusA4fPcMJnHWvY41
         pOXJ+z3JeYzHtNDHaA7j/KcC4AfLv9NTDTZ3VGbgVMjjB41R9/vo0pM/NycZmTEJ+fY4
         EWVE2vSWPDjp3ivk6kLabWHQiJ2x6Mu83/L9cc3PYoRxFkHu+2sTLbrnYb3UlXgKagmR
         qZufq6VtJhledn1ClK463JEA/ojNDdtiiXdXxriqzWyz8/QkCJPcLjnKI44t4XEu/7fx
         lVJ58tIi1dFpA2yeUHS8Az74BeNKUqqt+Km28gQNdqAHZsf87nIkX+af3NPoBugUPUhI
         ledg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742402991; x=1743007791;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otdawq32D6/5bERzoT5Rk23HrOvjEoRzM0gTHt/o2Nk=;
        b=M2YPPIOg+ijKv7rsQuUFQt4UFx0B9uqUIq1UDq6OoMIqDlr6zW5KIs9RF4XpAMvxDS
         O4XLyqo4ZiHFTe15Sngpb2SbLSqcV1fEdn7NAMLBwNLavFknQpSasbTyjrAp99U6hwgF
         AoPs7xMzbJnhiueTBqUkIchEKoZiJxTuXZizHdhCvhwbwQ6MsivojHe0XHxttHlO1+hX
         ZTTY+8sGa5Lr2QtTDBaxZUotSBO+LCP/Zu2xvrp5+aU+kfOmxjHDPiDG9xlwN+CQFDZx
         uDYBivakmavNWmf/aZxNdZ2HZIhzyh9lndwA8KqSI36exggzHBVKEqU7vHS5i6ylAMYS
         pyvA==
X-Forwarded-Encrypted: i=1; AJvYcCVSGbPzmSq/7lg0AInaYjUZZTN/Z87SMwCjVjKi/yd45dR38a45Hm7DCbDYCDyLAz+yJjQOdmskvupZ/1c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyZICzn6t/p/pqlzu+rSiCB8dgaQNIaf+t/Tx2LPcl1GzAto/yP
	SGS6juRe2mmksDwOGtaAi5SBAqZg1xwLelTvEzzwFG6Q8eSZ365b
X-Gm-Gg: ASbGncsKYYpPLsZXc+BlR415Mxs8wWKNDcLC+sdvlN+dGoyLjhWsDa3YQV9TMwALlHd
	+N9ELWFLZbs0GaSGIbz6klA+wHCBxvmBvkOgW2FZ7ksmRLfliiJES4VWrfbdbAJAIFfDJH56Nf0
	Kf+dReyU+iKG5V9SJdsq67YMkR7lvw5O7BXLFTEgyjAfPEnMlJLnfaEeFUp/N+ewmAFXFkse3L4
	uS6XoOQqpvlgm6LZELE7s54fldouf79soos7WnPJLCzoRKoOcKOOo6HlUpu0daS0qc/C9lxDTnC
	CRqaj1W+uhNkTdG2+9mnaa/ldognMJSG0eIOOXDXJxn2ShC02gxWD7vvKbsynXpemdFwvbVwLBB
	pItqT2uRQeVrmWMBQ7SH/iw==
X-Google-Smtp-Source: AGHT+IFWe5EGmpUjldgNs4K1HGGbn7yVxSWR9yHkVqi89+su3KAenSmxurHklNjkpkjyUU7So5s1SA==
X-Received: by 2002:a17:90b:4a10:b0:2fe:a336:fe65 with SMTP id 98e67ed59e1d1-301bde5816fmr5014331a91.10.1742402990848;
        Wed, 19 Mar 2025 09:49:50 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576bc2sm1863641a91.5.2025.03.19.09.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:49:50 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v4 0/8] ARM: dts: aspeed: catalina: Update DTS to support
 Catalina PVT hardware
Date: Thu, 20 Mar 2025 00:47:21 +0800
Message-Id: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABn12mcC/43NQQqDMBCF4atI1k3JxGi0q96jdDHRqANWxaTSI
 t69UWiRrlz+w/C9mTk7knXsEs1stBM56rsQ6hSxosGutpzK0EwKmQgQkg+9p44X6LGlDnnpHX8
 OJXrLfy85KCNSVKY0yAI0jLai1zZyu4duyPl+fG+bE6zXLx8f4SfgwI0wGhMZF3maXesHUnsu+
 gdb+UnuSDhGykCClgmArqzG/J+M96Q6RMYrqfIMtFJGVnZPLsvyAZAJFuB6AQAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742402988; l=1684;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=ltDzPnx9DrYQLZ42Mpq+ze7mXFl9npW/CfLcWJZUc+A=;
 b=h9W1GzNDRP1ipPJnnPG4uywIzZY/IGU5ILv0VsAds08ZDU+V1HSp+fdDPVblhY2OxMh1OFhxX
 7AfuI8FFiVuC3b0Lw9OpX+U3yF11FTPUZn8Hj7nxYAz6fZ9Iin/gMVV
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Update the DTS file for the Catalina platform based on the PVT hardware
changes.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Changes in v4:
- Split a single commit into multiple smaller commits to reduce complexity.
- Add `multi-master` into i2c12 & i2c13  
- Link to v3: https://lore.kernel.org/r/20250114-potin-catalina-dts-update-20250102-v3-1-14981744b2fe@gmail.com

Changes in v3:
- Remove delta_brick nodes due to compatible string not supported
- Link to v2: https://lore.kernel.org/r/20250113-potin-catalina-dts-update-20250102-v2-1-1725117fe7a9@gmail.com

Changes in v2:
- Add delta_brick nodes to support PDB brick board
- Link to v1: https://lore.kernel.org/r/20250103-potin-catalina-dts-update-20250102-v1-1-b0b7a523c968@gmail.com

---
Potin Lai (8):
      ARM: dts: aspeed: catalina: Add IO Mezz board thermal sensor nodes
      ARM: dts: aspeed: catalina: Add Front IO board remote thermal sensor
      ARM: dts: aspeed: catalina: Add MP5990 power sensor node
      ARM: dts: aspeed: catalina: Add fan controller support
      ARM: dts: aspeed: catalina: Add second source fan controller support
      ARM: dts: aspeed: catalina: Add second source HSC node support
      ARM: dts: aspeed: catalina: Remove INA238 and INA230 nodes
      ARM: dts: aspeed: catalina: Enable multi-master on additional I2C buses

 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 172 +++++++++++++++------
 1 file changed, 128 insertions(+), 44 deletions(-)
---
base-commit: becaccc292bfbd12df81148746043c5221e49da8
change-id: 20250102-potin-catalina-dts-update-20250102-914b06a4bdba

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


