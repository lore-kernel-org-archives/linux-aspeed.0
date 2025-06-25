Return-Path: <linux-aspeed+bounces-1577-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6697AC77B7C
	for <linux-aspeed@archiver.kernel.org>; Thu, 26 Jun 2025 01:31:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bSLkG0P19z30GV;
	Thu, 26 Jun 2025 11:31:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750837136;
	cv=none; b=l1NObAcbkZ1kHT/gkwIHwSd8Qe/LcVfI3HOa4+TYIe/6riU4avhSl0bvxtK/74i2Am8WvykdamgDXBqmd8bYH/rinK1496SevYcvhiLzDDSN5p8QAgQEeomxVRHCD0I+mzYW2EaaZA/rEPKPgNMHOSfUy9XmP5Qu3TlSriwB3sFs/geOQUhpPgj7G5fmvscSIzdfKThQ9NCNI1BckM9F5Y3lepYKlYr5n6GuIKrm1fxrqJD9pYz59e1vNpg6jkvbMCf56Rs39FKIxqpSar/V+5WiinqOysB2kjNTstcmvCsWxOwFfMB4xpX/taVc24d1AeCRv5VjHz+WwpWWFqtTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750837136; c=relaxed/relaxed;
	bh=kG1olUInn/LVZERQ5W1mrbwIx3yXWmY5X23lP+cvHI0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TEBMWp6XvK4RwOumi5l5/YbYtFzQmVD33x9L4n9f4O3RuVuxn/N8gbbAJE5zGmJHqSidRb2VFrcnPKMtncn8c/5n/IAflz5MjnW3qsWh04zT9rBINIXLxd5YxqfN2mAfCjaj7oPvTKlQ7+ywCH522v8wFQJT3ko59QFSL4vp1wE/4WjaxNyqCdR3tzkthPYpWQ0u4i40SuNx6UomnQcqndoAdLL07HCJJOZ7GckLwVCMyFcPsCxwhp3LVKutbhYDKMPT5RNGZoRw2IhsL71xdm+rOeZ3GCVv3QPujeElrfDhKK6Fd/5+rqdpZUKDNBhJCy8Um1LFZu9pUw6MlQs8aA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aGeLU9x4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aGeLU9x4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bRtwv18Rdz307q
	for <linux-aspeed@lists.ozlabs.org>; Wed, 25 Jun 2025 17:38:54 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-23649faf69fso64450225ad.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 25 Jun 2025 00:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750837132; x=1751441932; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kG1olUInn/LVZERQ5W1mrbwIx3yXWmY5X23lP+cvHI0=;
        b=aGeLU9x4Q3mLXyTIfSPdIczk2DKjCWsCgOR09JCjcRtpQHWlkrBhUJoRNtSjkaXPhL
         gwCktGM3khkwdonjd/71VaV0d4XAJ878lrFcx18AnyXAnzGFg/4hz7JDH1i8aAFroQEi
         0afMSHdNufs1cKxaGmN7AAkOJHDEEdsYsz/8CbWpSJkHqVArqwWIJwoVWr3YQkJjxAV2
         nNp3YpK5quQjhgkDvq9M+lJn3OCCykRpRoLS1atRz1e2EJ/nL17fPCFPCiNmlOTKZqHR
         7keI6/y8WuQgS3O5LuaY8TbN3zZ7Q2nkMk/CazdQ4kjVWj4We+hiCCSs/c031QjHlSY9
         3dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750837132; x=1751441932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kG1olUInn/LVZERQ5W1mrbwIx3yXWmY5X23lP+cvHI0=;
        b=npO4IEwV/bKC7bAJV1qXop9yiPjCseF5NCmJM6qudC05n5scOMxkm4kFVhG6dVeJ+U
         /bPTwlYZAaDqXt9Ui59CkKDwMBYEDNNTJso44Rc3f7bTHmnFIjWqo5vlfCR0GL9+n7vE
         vfDPDEJFqAk+sU1bzxYhMI3lWCb8D8oGL0C3E5h58rIoVU+60ztsxkRH4DPRYTc3f9I0
         QqJsC58SRNAcjEZGuRlBIexfAP+nXca6+HKvhweWW9U2DHQsZE/RNfrrwbsZeQa0b9jq
         mF5ihiPXMzytSehkdYFTMT77dasr60hXl65lobbumpQCKYDLtdabf+hr+bzjuq+B/aj+
         TRsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbOpMoArjv4CgI6ezkHVmMht1SWRXeQ31d5nyat/q4ERz7XUN/hQlFbZbKyTgkdXnnut2CxZfBX2kPoLw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzIo6nX+3+FZ8ypyH/WMwNBHTt9/A5yOhPhCGqVc5r4W+EYNGbM
	Wp5MQkUINGiT4yba+28fARqbJyrsOWdAinEMam7NRU7nl0Oq9x0TgmFu
X-Gm-Gg: ASbGncvDlKx6h9SN6Sh3uMKZrfU9FMjuMe7/93I5SvQXmTqOPhyp43UMVbdjs3orAcK
	+qB1ZPbTa/1f1UyKUD2EUcc0TbJdfAwYQRn6U/n+kyDJOv0Eh13F7Q3xk8C+yuEOWFUn2iYrqO9
	2HjgR9/fPO8VNe4R9G5zCmDHsb3czgDbBC922S3VpqNjnARfgxG7bHAoH0WwgEUNNtivGoIswFy
	XGb1AJ3f5S1CkMH3e+DeoKlDMDyuqOCIoRvBoHREf+5S545ylVcmzKDwEJi9OuQnxhUFn4ZUL4S
	2xT89O9x4isshnD+OpHGLyFxr9HoicN2RRtwYE4oL5tlfbVKiE/Yc/YzVSLJAXHR1hSkIlqRavc
	StrrfNIRIc/WccT54HTHuG0rIjcsxu0V6Z5qrzvpfnonxPsuD2T37UjNwY44B2AImyr4g2NwfPO
	jfU9aX7NnTcf9pdg==
X-Google-Smtp-Source: AGHT+IEAYJ2SDUHupwKAlisVD3ai/2xripja2VDUoY9Ul4K/z1BlfG/iLbXNiETNKFpAqA+j53TumQ==
X-Received: by 2002:a17:902:dace:b0:234:eadc:c0b4 with SMTP id d9443c01a7336-23824079303mr47397585ad.44.1750837131671;
        Wed, 25 Jun 2025 00:38:51 -0700 (PDT)
Received: from fred-System-Product-Name.. (2001-b400-e389-b6b2-29b2-bfd3-aa15-d345.emome-ip6.hinet.net. [2001:b400:e389:b6b2:29b2:bfd3:aa15:d345])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86a3083sm125374285ad.195.2025.06.25.00.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 00:38:51 -0700 (PDT)
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
Subject: [PATCH v2 0/2] Add Meta (Facebook) Santabarbara BMC (AST2600)
Date: Wed, 25 Jun 2025 15:38:36 +0800
Message-ID: <20250625073847.4054971-1-fredchen.openbmc@gmail.com>
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
Add linux device tree entry related to Meta (Facebook) Santabarbara
specific devices connected to BMC (AST2600) SoC.

Change log
v1 -> v2:
  - Enable mac3 node
  - Add GPIO line-name FM_MUX1_SEL_R
  - Remove 'pinctrl-names' from gpio0 node
  - Reorder top-level nodes alphabetically
  - Reorder device node properties per style
v1:
  - Create santabarbara dts file.

Fred Chen (2):
  dt-bindings: arm: aspeed: add Meta Santabarbara board
  ARM: dts: aspeed: santabarbara: Add Meta Santabarbara BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed-bmc-facebook-santabarbara.dts      | 982 ++++++++++++++++++
 3 files changed, 984 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts

-- 
2.49.0


