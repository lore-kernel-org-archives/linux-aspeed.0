Return-Path: <linux-aspeed+bounces-4044-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914E7CD343F
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 03:40:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJk8z0v50z2xfB;
	Mon, 18 May 2026 13:40:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779075294;
	cv=none; b=M/i3xINmQcmUzN3LZFrtn/r1Xbkpwmiqnui5kA61adVgGbJTrU5+uorxiTnWmBWT6YSVn0/CnX3K4ROWT049Far3kZThNg5tRLDPjD5eWQJtdhEc5+g2KPpg126Nrcen25rSBrMiX8dWOLnW7d8zac8S8sDiLQlSOE29w3hCyhIzU03ljsXMXSYpiCKAC9v6jf9S92+Tv2HYRgeTudstuobtISmxwTbBs4GVzUO5a4zYaG4yoXumXewGtwSjaQJjT1AU9b3ysGhG/1K5MKPGC+3bjcMGeAPaA7z6eP7P79+MNctY82SeaI/VQ16w4utz/QZRo5nJoYvKZrSmY2CZ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779075294; c=relaxed/relaxed;
	bh=O4z4QeYZgLmQ+74XBWrLJRwdCJBglkAJbbIu6ajXqKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ws8oJy2zEaxANS3JPunp9aC/t8R4vR+x1oX2r4E/siGqfjd582dn+sew11wix/XEebcEjdSJ1dp5B0t6CaJWdQKHnOfy3rOKNyn6FTmVklGCXMfKb2ZrXh+rBbFQABxCVVMfNv44eFVJAfazKMb6eMvr3oOcEFlj0LWeI3+Zi0fr+o0V1NXQmjfHe7UwNUtIAXuaPuHDvwmeXdr2BTfA3U/un/lbH3ifpCFpvu9W/+zcZDrZPLqqyHdKa9GMHjeQbjwGgjx4++lUim+NbamXuIPbS75YJo03/i/F9S/ySs76LxJWWiGWcPtptI3y//9S5M9cJlIh2qt2iCwj6p8H9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PJbdb7P5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PJbdb7P5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJk2N5Rrxz2xRw
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 13:34:51 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-c801d732058so604624a12.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 17 May 2026 20:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779075289; x=1779680089; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O4z4QeYZgLmQ+74XBWrLJRwdCJBglkAJbbIu6ajXqKY=;
        b=PJbdb7P5VmaqyewLge4eRRXnnYO+dRHdyLEeuyaQ27bdkOE7Kcz9wLhWr2a+msWn9E
         86QLMn+SQRCw5bBwyJ80OJMUiZl16UkI/N2HqKkS3PJm8AH7mpofelWQaq1lpEkRIH/x
         zZEnsLqHQjPDAV81TTjD68T3bBBS6GsDdinFj5bQAPC0Fh20u7hIu0jTIb+N8Z5XSHJK
         4EbLdTRtuCSMTp2AGjjdHgK3UD3lDE54KUk5kR7Mks5h1MUqUABJLOBC2hRiS7GnhZL4
         wUMXbYNxOIKMXUBuUwcBU92TqtWdXCGTyaIfA3XHqKQKJ9EzcUAk30xqICl01Vk+OxbZ
         1bXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779075289; x=1779680089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4z4QeYZgLmQ+74XBWrLJRwdCJBglkAJbbIu6ajXqKY=;
        b=gtciF4KoaX92vSQtnSt0TIakHnTBFb4ZtMI+GdjQgTlQ46S2N84gi2uUWy2iYRn4Y5
         mxXUziati2PJOvwZ6mpPaduRSBUbyUMIAK9sQN9QIJUlfup8rKEi0Sq+70KutH4EDTX2
         AfosuC55JmgwGiEy9L8Zj0DwRI5/dsUgtwlmF7HYW22cpgsDKm3R+MzYpA1ot5unrKM8
         7QUyGG/dGxlNiSToXT8reqYuJCfEgOoOzYiEkGf91aYdx+IiqgtWcPyclFEvPjWPPfED
         /EHfH1+64hs/UHSYsR8makTuFOZuuNM89iar1CDiFSGBrirhF3Wd5wUwNJA2giDVHKh4
         9F6g==
X-Forwarded-Encrypted: i=1; AFNElJ8FtSTgyMElERqQa/EpAakuB6GHYIAKA52zhlG4bQSazaXc1Q4n3zUqkbJ2VFrtryUsWEfqmBlp2lZ1bX8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw3YxXPD3zvpMZyXGUH5i6RDFjmQ9mpz7JDTYg8R6HxJEEMSRuI
	rrnz8LgQn5uICGuQ6ySP5/A8iT3mQMgKo/IPd8ogTdbcvXpiK66mMHww
X-Gm-Gg: Acq92OFtegZbQUHymlkxsIoWQcw2ze9rnbDv9y8APSftXDU7Gd2g9Ixvrri1eDZtlfP
	lHzoyeiiHG6VgAHr12b7V1ZageV+sZ6MzZl3rsiy7vcIGlcDM+OIaYGudUGuwS6GLfDIMR45S0y
	fMvYj8lijH3CfhVt/es+j+Twn6MVG9AL835mrhtdR7+0WJFgu9T7UH4L4qyCQQci6et1DMJ5dE6
	fhwN2Kjd5pAHz1GgO+o3k34tB3Y5GZTSL8KQ96iblJ61iRn9i5aBhTHD6rcYPXdSGxURwQBm6PC
	xs5wecnR1x1PHwCUDlL/eV75Efghh0QWYWyMQu2uMF2aygQK6I04E4P/v+3akFMxJapZcs1ou1Z
	FEKAnuqNu7ei8nHN+YV0s9Z7AcPumVVPhPuEQ0pa2v03EcEhQjmeFI6I15jQ7SaqXj8KBxaytJx
	vAgRd65PT3qiTBCatyLoubbMeMGAZozokajctSA6lq
X-Received: by 2002:a05:6a21:3987:b0:3b2:8674:9830 with SMTP id adf61e73a8af0-3b2867498e9mr3029580637.14.1779075288739;
        Sun, 17 May 2026 20:34:48 -0700 (PDT)
Received: from debian.prasanth ([103.177.82.201])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82c4031662sm11183717a12.16.2026.05.17.20.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 20:34:48 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: andrew+netdev@lunn.ch,
	devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v3 0/2] Add ASRock Rack B650D4U BMC
Date: Mon, 18 May 2026 09:04:38 +0530
Message-ID: <20260518033440.17569-1-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
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

Add initial devicetree support for the ASRock Rack B650D4U BMC,
an ASPEED AST2600-based server management controller.

Changes in v3:
- Reorder board DTS nodes alphabetically by label.
- Clarify that the management LAN PHY is an on-board discrete PHY.
- Keep MAC0 phy-mode as "rgmii-rxid" based on the extracted vendor DTB.
- Keep flash layout unspecified until it can be validated on hardware.

Changes in v2:
- Add MAC0 dedicated management LAN description with MDIO PHY at address 0.

Prasanth Kumar Padarthi (2):
  dt-bindings: arm: aspeed: Add ASRock Rack B650D4U
  ARM: dts: aspeed: Add ASRock Rack B650D4U BMC

 .../bindings/arm/aspeed/aspeed.yaml           |  1 +
 arch/arm/boot/dts/aspeed/Makefile             |  1 +
 .../dts/aspeed/aspeed-bmc-asrock-b650d4u.dts  | 71 +++++++++++++++++++
 3 files changed, 73 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts

-- 
2.47.3


