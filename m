Return-Path: <linux-aspeed+bounces-5085-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A37CA5FB1
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Sep 2026 11:19:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvsxk379xz2yqT;
	Wed, 30 Sep 2026 21:19:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790767146;
	cv=none; b=HDW3fOyoAu3NVHbxHuwWjwiDzgDRmwA6pF2Z025ZjaCF1+9fj8VNVZvPnAnmpCawRPWItS/ZqRyD+W9NOkpzpeTrN7d99fSLqnj42+9VgTbT4KkVo1NPwMlS5JiAoUrxInTNxLQN1QhNM3TNX+Y3tSEiOnjbVISvmwjvYBUYPyIDNGT+kbfGIqcWGu1pPvcGsIJTpB1wo4Dtv16tkh+zK+lTRh5IWI7Hhl6moV7oYkkoIocTlnsV6yM7AqMuRYohEWReIO6QPWtMv20keUR07qICyavqiyMBOgjgTuRhysFIzePL/6+U5wC2QfW/I06Wf43/sOQnC+n+1lnhfa/esw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790767146; c=relaxed/relaxed;
	bh=+yfqfhizfQ05zp6V77MZ9T7BSR5efZzEVT2zwBnQMYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eks4YLUvgm0tsmh+l2LlKrr3i3S9C/vYH/TbZmZaqL3mzsy+dnta9Vnfr5zEsVwB+88LeGiXkLJ8mX5kSV70IXJt/2wp548R9y5O9ZEoBqy0ap1R2A2DfglD3MNpRSxRfO7cRxoe6DjFH/gERf0BJtlgYAOKvbFYwUAj+Wp6VV6Yp4xwEMTrz/mpBKra6qGcdQKUP7NvyS1+2qUyTQJPtUmzDmG5T5nn85lXG0NbUW4HRy2wlwO4j7mnqh8av6OR4qbjLoge6UgR8FV6c6IIQUO8ZYe88xqtc6EDuPNR4d+5lNP2cG1lY5KskFCJ6fIS77h1JeoisG4TDy1RCkjxPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H6yJCM/X; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H6yJCM/X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com [IPv6:2607:f8b0:4864:3b::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvsxh6F7Mz2xmh
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 21:19:04 +1000 (AEST)
Received: by mail-pz2-x10.google.com with SMTP id d2e1a72fcca58-8686f46e4adso3342861b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 04:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790767141; x=1791371941; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+yfqfhizfQ05zp6V77MZ9T7BSR5efZzEVT2zwBnQMYA=;
        b=H6yJCM/XQgX5rZbvUpHben6hrYwsUdVImC+nev5XXMoP1Lyp2B2XKgzKUuJQiXZt+g
         n1Me1/ORq+28uAqmblj25xgFM5df++ncOehwG89Tjrv0DEsdEnEuZTWIly/Y+jeBKo17
         KVSpqygjZL2+2L/0zxIeW/nuL2bGXXwSUZGvmV8+JEJM3+/HjryJFSWMySuLtILSqP55
         lGDeTLeKH0HAOetCpts9SpCuVlhsEekr/8ReMQfm6QTEfhXyIuTB2FhFE2JoRTBncXOl
         ZfoxWAycpsB6+sjjH9vf5J1/ANv0CK5UXE81Ba+geLXj/+HIkgsF2R0Pbhckg984dmxZ
         MOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790767141; x=1791371941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+yfqfhizfQ05zp6V77MZ9T7BSR5efZzEVT2zwBnQMYA=;
        b=p4NTc5T3W4djwLqSlb2dFkOuRygE/WHpAzux5jA40JX28pdlUP1L0KVAsTBj8LSrNI
         rSj1eHwUOT5r2mRkCC0GmSqcuONVvUBQ+Q4nDziP1v2DywqFGqIv9B8mmrewlU/u0zdm
         QnuozFDCSauliiMmMhASa807GAELAdNzT1urnroGBpK00zj8Kd3cQYqqH961F5ShzSzb
         Sw4Z3+GZJ6KwYABSJ6vAO13iRo2WDYXYm7gVK8U8mKPoQW1yhMbSGTmhDuwNK7Am45cF
         MKnsByMGYvbQVL/JGV/SR08+91Y6Em4HUpI9zDtd3RP/nd/IedQcaMCZqF8qqhzBOhpi
         JjLg==
X-Forwarded-Encrypted: i=1; AKwUvByCGqzw0TE0Yob+wg3QdWqlp0/sQShKA17kZLhZ+KSP0fTUbZou3ECZSsUd5o0UnfRr3unQRou10RAqb1A=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mNHrLIngd2oHNMN2pMuzFJMJ7O4tqZdt+atvB3dhHBe28WjdkJ
	VTvnDVL+g6HMZIINE1op56+vrIE/fNgcmWbki0UFA83GL+M8rI9//HgE
X-Gm-Gg: AYBFou0kUPbkgpcV0oPOdFhuGRBnLk0JAyprPtnj/ydyNbiJEnTDrk6zv/2wPbIxYQw
	00wGbPVN0ViiKVOhDViQ2tc9o271441GOTPqjla/lPWg4mRQW+mQG4JBELrxQ2CTKfLT+2zFotz
	P0nmNy8I7ySSTO1PgGOrHf5ny/BboVi3VUqjq3A6Fvj+KBZ6qU389SkTufsxHciIK3yMk8A5Eqg
	4oHn3yRm1MdeGXxfOASyHtMNuO/gU2vCOg3nnxYAAxq2fCbgeEYKHBED2/OFeF2oDMUaPCeYJcw
	LTL79EScCJGchQOymuIKHTKSt+geRTnF9EUC9YHFjDdEH9MKPwSBllp/oVvdM+IxQCBktg6YKH+
	1zncMP8vCIPSU+q4eW0dLU2j0WJNakLeVcVuh/nykWjIZsrtBiwTT/Hc6HmN4x01FE7ChD4IlNy
	ODKxYcS9TDbzl8Jh3hZp3XUaZ//qcKDXyJveP4DBnNHXeB8oqWECKxh6WxhSwTFOHN6atUUA+B6
	AFypmQz+qomQ2e3bGf4e2fHbNbQGrG5eVCrcbwmF/EY
X-Received: by 2002:a05:6a00:2396:b0:880:78ca:8411 with SMTP id d2e1a72fcca58-8874c4ddee4mr771398b3a.11.1790767141213;
        Wed, 30 Sep 2026 04:19:01 -0700 (PDT)
Received: from cosmo-ubuntu-2404.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-887253992a9sm650257b3a.17.2026.09.30.04.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 04:19:00 -0700 (PDT)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	cosmo.chou@quantatw.com,
	Cosmo Chou <chou.cosmo@gmail.com>
Subject: [PATCH v3 0/4] ARM: dts: aspeed: bletchley: Cleanups and second source devices
Date: Wed, 30 Sep 2026 19:18:09 +0800
Message-ID: <20260930111813.52396-1-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This series resolves dt-check-style warnings, sorts I2C nodes,
and adds second-source RTC/LED support for the Bletchley.

Changes in v3:
- memory@80000000: keep "device_type" first, per dts-coding-style.rst.
- Link to v2: https://lore.kernel.org/all/20260729114312.3947300-1-chou.cosmo@gmail.com/

Changes in v2:
- Added patches to sort I2C nodes and fix DTS coding style issues.
- Carried over the second-source RTC and LED patches from v1.
- Link to v1: https://lore.kernel.org/all/20260714120816.1504058-1-chou.cosmo@gmail.com/

Cosmo Chou (4):
  ARM: dts: aspeed: bletchley: Sort i2c device nodes by address
  ARM: dts: aspeed: bletchley: Fix style warnings
  ARM: dts: aspeed: bletchley: Add second source PCA9532 LED controllers
  ARM: dts: aspeed: bletchley: Add second source ISL1208 RTC

 .../aspeed/aspeed-bmc-facebook-bletchley.dts  | 1315 +++++++++++------
 1 file changed, 902 insertions(+), 413 deletions(-)

-- 
2.43.0


