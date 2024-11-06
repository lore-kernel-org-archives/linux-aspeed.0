Return-Path: <linux-aspeed+bounces-85-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E2AD29FB8
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Nov 2024 09:01:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xjzhn5DVTz2yxL;
	Wed,  6 Nov 2024 20:01:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730883689;
	cv=none; b=FpqRNxl2KzebHuQk/Mg7XHnjRENgbMHTLXQIH597tsP1gRR1oss4UkN6RfZ+Kj/q7SNZhU2YcYUVA99pimf/jbmHQePj0vkmhuvAore8hECxMGrDYHnX9wMtdJ9rWbXIgEYMskkQ/Ik2DrwAdMLVcqzS58KPUKP8BJT6OhQ9XVAX8SVUS9GH/QYejYxE+Kt39gWqr80RD2zNKDNhZ0WR2tSd8rLqOGQz64/O+xsleQ79wLncJ5uEZJPe9LHNE9Un6PClUWn0miJu3N5w3EyzNwWrZfv2gPVXvSIFaf0m8SlsZGfaYGd5dPvxX2C4KU40Y6/YpC1JK4s2GzbYh69zKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730883689; c=relaxed/relaxed;
	bh=dN34SSgBwYUCwi/Jxu+wRXh/eB3/vsROfybEBktpwsg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ktlUXf9Xpaa3Vfkn2wd6tST90JinjByOTqK8SfcRM4GpATEFoxTs4KJclWc9r9LiL+E0XrpIHSHArs+mkdRWe7FP0QtKMDLpFhUUEP5uX2Js3r+wSvQktAzMi06Rwr4a0b08fFX9Ia1K3BlpvalmDjWqVMf7DsdN29eQ03sq5HfvbKI5KodmK85OxEgUjyx+L3CHZn1ZohhDvoxWAjiGnLu8UR1U0Eivlrvlk3hby23dzMPGK5yKdAvUkgs3wC71i4WTMfjbuwzNtPPgaEiaRB1Kcbci/WxF5x7sx9j4ucvdUQSm8ujXyJmfwLD8qzQIFO6cCXiWK+mDe7AfXVpwaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=So0v+rnx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=So0v+rnx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xjzhm2D9Pz2yRD
	for <linux-aspeed@lists.ozlabs.org>; Wed,  6 Nov 2024 20:01:26 +1100 (AEDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-20cdbe608b3so64286605ad.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 06 Nov 2024 01:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730883684; x=1731488484; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dN34SSgBwYUCwi/Jxu+wRXh/eB3/vsROfybEBktpwsg=;
        b=So0v+rnxjpLaq++JIqKkda0k1QFo6qhprjO8GBXc1NFcuwku+awMmFJeqRoQrnlHQu
         AM5JeVFsXekLHsaMWNu4E9z5WjDyvWfhWJn38IOzmJ1W2F813E9DfgUJt8Z00ks5GrLq
         Ap8unq3JNVQUwJNrLqd9euyPOedaY00eEAnXvD1iHfMa+6/kgqKy1ZQzTN+64UO6e9zO
         U9V9q02OmtmCcBSe1xmv7ABsTirgLrjh5wUd2kE2IjSAZ20bA8OAWcOhIoH/n88X4kkg
         27wv09OpyhPrDRULQxdRckWI/OJzJ4LBBpuzJHiaFkjBtymVG2OCvL2sQQAAy38Dbb+c
         YeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730883684; x=1731488484;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dN34SSgBwYUCwi/Jxu+wRXh/eB3/vsROfybEBktpwsg=;
        b=C4BBxlIuCUTFibkd6vO7qcJgDXCOQSt6gyZ/eDUKuVlx8n41doOXme8Z3hySDv68iU
         0Srb3hz5I52Md8RCRwMJGLK4j9srFawg3oUsMtGsEcNkZnYFA3xaA+WmaglMNihhe1D6
         +Wq2mreaA9LHzMp4+hLFijP+niffhbiqfNB1AZJn3k2T1gopaW+Wg/60ZnCYi4vwvd/s
         HdKbSad46obUXPk/G5de5fkkqW2yu8VAiu4845Bl6jPEJ6+L5C67r0xcuX4msXjA4dnE
         MBXNJdBMyqVKwvtOmbNxQ3UUNMI+ciHZvDMXtsdBA2IXr252LDNynH0RDlWm82LIr7NJ
         VtEw==
X-Forwarded-Encrypted: i=1; AJvYcCWJsbhuD874q826eMWfWa32iIRvRlNv1rPFckTCZMKZO6KyIau7jTzs+UYg4IY8pd5BlUYr0+WDPfhEL/Y=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzyXpC4wC2td6h7KE9/VLDsfmtYh/8Yd8VZlO/1WxYyn1pWtsw+
	eXiUVgO/2s3ByOc8rf6xdzlMdcQdFdGMaYnmZd6Oarfr/0u9F6nbELzorg==
X-Google-Smtp-Source: AGHT+IGnkFWynLLU5/2Q69B9cDIhpvlGXMSFaoZSiGRLdCoNVTx1MDEWli01wkh9fzWNeKIA/izOUQ==
X-Received: by 2002:a17:902:cec1:b0:20c:a19b:8ddd with SMTP id d9443c01a7336-210f76f2952mr385802445ad.51.1730883684628;
        Wed, 06 Nov 2024 01:01:24 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d380fsm91317665ad.240.2024.11.06.01.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:01:24 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 0/2] ARM: dts: aspeed: catalina: update CPLD IO expander
 pin definitions
Date: Wed, 06 Nov 2024 16:58:50 +0800
Message-Id: <20241106-catalina-cpld-ioexp-update-v1-0-3437bcfcb608@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAMovK2cC/x3MQQqDMBAF0KvIrB1IQijUq0gXQ+bbDkgMiRVBv
 HtDl2/zLmqohkbTcFHFYc223OHHgdJH8hts2k3Bhei9e3CSXVbLwqmsyrbhLPwtKjsYERrdU8I
 CpR6UisXOfz6/7vsHoiqHUWwAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai@quantatw.com>, Cosmo Chou <cosmo.chou@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730883681; l=613;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=4PoFtxt4Dc071+Aor3cOXjBAyVvWgANaB9cgnRPVnao=;
 b=5pNiHn4f7T6DPb7g/9DOVkSstHqYNgW909o72dsst+ZevKNbg7fFnzKUdhkOrOXHuHdJMWbEN
 uRzgp41XATMAcio4YwxNRdvph8iuwYd/tCnNeLHisu1MY0Iaj+/OQka
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

This patch series updates the CPLD IO expander pin definitions of PDB
board and HDD board.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Potin Lai (2):
      ARM: dts: aspeed: catalina: update pdb board cpld ioexp linename
      ARM: dts: aspeed: catalina: add hdd board cpld ioexp

 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 150 ++++++++++++---------
 1 file changed, 87 insertions(+), 63 deletions(-)
---
base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
change-id: 20241106-catalina-cpld-ioexp-update-e4ed409a2fed

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


