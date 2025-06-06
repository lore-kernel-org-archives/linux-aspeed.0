Return-Path: <linux-aspeed+bounces-1327-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D681CC677C4
	for <linux-aspeed@archiver.kernel.org>; Sat,  7 Jun 2025 02:06:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bDhPF4wczz3064;
	Sat,  7 Jun 2025 12:06:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749178504;
	cv=none; b=j3nHPJTsHzuncucuBKFZicmQTciq7izRt1CYOkSGgKHVOliI/KKLkSB6V626qJjY9yDCV74RHRgokVl8eOnVai4i8el/UjETs9sEmb11X5yCSfBxa2wqFW2H39CStLFgDDHIHAbb3I9ugACCo60rMBHdatpmdfhHYJqvQ0MZYaLSFNqUNJ6NBxP4OOIRS9L7GRLBukrDtqxKjj7WitfCXsAp3Px/bIcqPBFmYseBqHc+KgV8aIiylc7IcgDhCmswo9YefnEgzHPCKHYIAPfWMzTeSWn8fn4xT1fSZ9sS8xJkJeNZ4P4mzksh4dbe75mzpphnA/bdv+tgQnv+KEHgww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749178504; c=relaxed/relaxed;
	bh=JqrGZxZfe4s9xgG/EFT6KkjJVPgG2O2ieIG0K5ZMp14=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QviqmOiaBnbcb7cAxTpNM+vflIybnHfKDabBjd16hSZwgLWJsqQe/tfXh41DfmESTHOLcYWzvkuCzZkQu4YEX95VKjVfDmoJWcLIElGFISraeGgiIcj1pPZS+/pfFM7XN5DFpl567TlkwNrfxAaNQqPDKDktPOAncPgKdb34GoiN4R2wfiJryW6SlwJnQXCQ5UaUxfwROql1yNb6yH7+s0VRWt3vqfsOM7htUoHXMm0GSwSQ8XSYfrVlYIciIiXH28a7Yvepa9Qaonc0eIMGv7B3Wdas2RzIhrfBYeubFuIrmdh0CE8B/7z5lj5gD8dHU1BbJWH4Hgk+zK+oyJiQ2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jaydvoYL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=jasonhell19@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jaydvoYL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=jasonhell19@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bD5X66W51z2xYl
	for <linux-aspeed@lists.ozlabs.org>; Fri,  6 Jun 2025 12:55:01 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso1315194a12.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Jun 2025 19:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749178499; x=1749783299; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JqrGZxZfe4s9xgG/EFT6KkjJVPgG2O2ieIG0K5ZMp14=;
        b=jaydvoYL3+4ojeZeoredxVv88RPRv2jJfd+wtsKLr0X7Tdw/3glZWR9E6jOYKRu070
         q4MrdOnM/WxV0PthUHOWxJK3PQcZFcec7xGPVm99hl4r7thQvlo563v17odRjZI3UDM/
         4wT2AuRbAvteCjFeTnEz/HEf4fQ9ennIU/VvNsUZNzuhhmCFl8Ued4seRYly4rTBcTYY
         Ct31dDJv64G7igYL+ckSu70TSNJ0DGihCUjDROztKVIPCd+vXNx7fDSK0N/1W3QZ/Ixe
         eWyydLwsqGIjuAk2V/Ck1c2bfKU37YOYPCE1ZjlHo9ZBVN7BuZ1EYVFdlNZPgkg9ppBY
         nl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749178499; x=1749783299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JqrGZxZfe4s9xgG/EFT6KkjJVPgG2O2ieIG0K5ZMp14=;
        b=sFtJYXUT83lhznTs6X9Bd/v1cQ8/6c7KW+ucOc2C9fdtFgkh7r1Ofv2wqQIgdsX6G5
         JH4f2mY0tPGVAnU1KcfE1VbNKwRDAGdKQsFU3dxPUcPot4vJ5WcrDOx2+6sfGS+GxOKX
         05YufHT08bgh5QoyDqxACICooHMcR/tM/RpfIrQn+Xrb+PUFviE64XSD/44jzCNropCy
         Me2ZCDMPoSu/5WRyhMpVUolbb3DL/ebNIgmQ97eUrsRhY6GKNJNjKStFD+A24OHYx7i9
         oUrE9DLwqSWCBi51wR/Oz2jrBrqmxPNmxuAUrZMRgkbOX5Zf3jMZUjZBWt9pbqn1A0DG
         WOUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGTdebpAt9+mUukEC7ZmkOayf6epCdENtF8f4fs/4q7QvGoDLeXMZEBH/AF1aMCGwIhw/x3kGPYjCktwE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxfDkHzo+vZIRdvZ9BvsQxvAngA7GTsta96/Xe11NIi9UJhl8ff
	DyVfqlnKCw66ipDO7i1L9DoJCFmQUDfa8diYZA8AtP6fRkshfYLlg70V
X-Gm-Gg: ASbGncsASPTwalOaCeB8IvtzRh3wgfzSTnnLVMq7vEx4Uz9Q7Zpiw2L0rrPQEqTn0h7
	1AJDKxyuREmFNl1q492Kyy9HdcMaZp1a3rMpVEd2DAcyRR6UgRKVY/LpdBkA4p10tdUAEaE8G9w
	5GvrdoPsDv8k/mH7ZMUnI0PN4pAbwg2+qDtvZjlE8f1FpZ4fL0yQVh4RxSSAhaslf7K7VOIccr0
	tFYmaNwRPnagQwZsVrmnPgpjtk8+0NGuWhSEHl0OrhGpxofVnvL0HJOLnSS7JfVZarK3dSSj7US
	7lHkl+0TUP1Ml/xXzeXk4BhsPeGgYIcjiEW2PLZ8hh6vQqti/GYb8tYoQS/dmbIlE0zzkr06Kj5
	e5vJTUhPnhIZzf6XpKwujkjgLjNOA0zyZtEdXj9iWchMXiMtmwZ4OjBIAGpP4Bm/awOItDDFP/z
	C0l28K4a3nPw==
X-Google-Smtp-Source: AGHT+IHB3aHU7n0uaEQbmWTSYTIEsb/YABqewfurUM9yqVpjSkQhfmqbYeHsudldolnne0QyhmNdrw==
X-Received: by 2002:a17:903:22c6:b0:234:986c:66bf with SMTP id d9443c01a7336-23601e21e73mr25301895ad.11.1749178499573;
        Thu, 05 Jun 2025 19:54:59 -0700 (PDT)
Received: from jason-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603077eb7sm2942185ad.39.2025.06.05.19.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 19:54:59 -0700 (PDT)
From: Jason Hsu <jasonhell19@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: yang.chen@quantatw.com,
	jerry.lin@quantatw.com,
	Jason Hsu <jasonhell19@gmail.com>
Subject: [PATCH v7 0/2] Add Meta(Facebook) Ventura BMC(AST2600)
Date: Fri,  6 Jun 2025 10:52:49 +0800
Message-Id: <20250606025251.887953-1-jasonhell19@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Add Linux device tree entry related to Meta(Facebook) Ventura specific
devices connected to BMC(AST2600) SoC.

---
v1:
    1. Create ventura dts file.
    2. Add commit msg.
    3. Use format-patch to generate patch.
    4. Add subject prefixes matching the subsystem.
---
v2:
    1. Modify email content.
---
v3:
    1. Add mail list.
---
v4:
    1. Apply git send-email --thread option.
    2. Sort nodes in the dts alphanumerically.
---
v5:
    1. Run scripts/checkpatch.pl and fix reported warnings.
    2. Remove unnecessary 88E6393X CONFIG FRU.
---
v6:
    1. Add a new stage for the DTS change.
    2. Run scripts/checkpatch.pl and fix reported error.
    3. Fix the issue in a separate patch.
---
v7:
    1. Fix broken indentation in the device tree file.
    2. Sort nodes alphabetically, then by address if equal.
    3. Rename fan sensor nodes from 'hwmon' to 'fan-controller'.
---
Jason Hsu (2):
  ARM: dts: aspeed: ventura: add Meta Ventura BMC
  dt-bindings: arm: aspeed: add Meta Ventura board

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-ventura.dts    | 1481 +++++++++++++++++
 3 files changed, 1483 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts

--
2.34.1


