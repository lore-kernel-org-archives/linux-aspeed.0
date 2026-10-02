Return-Path: <linux-aspeed+bounces-5106-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1682CCA5FD4
	for <linux-aspeed@archiver.kernel.org>; Fri,  2 Oct 2026 06:29:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwzR00Bfsz30Bd;
	Fri, 02 Oct 2026 16:29:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790922587;
	cv=none; b=BWnr2FH5aVKlxwJBtixnPTJIlVsFMVZP1rDCrrwSjU2tlbZZaTIN3BtJkJrFZUu0b2U9R8Uxbj6s6F1nmSAADHdIwLwVLPYqyOH99lr8KEJZRWMVicqIoN4D5XK8FSG8kUCmm1cXy4ewTlP6Md6zsRr0cnR8AiGt1eoE+OI49OfvP4dGHTBldS4xoc52mKrH3DMy7WC4VcbzCu1fZ7O24XyQgrgGr4Z3oj0ZUzLW7JbzzJpq9JPdg81h9T48gLRZsH4ITr67fXIHu+n4V5gfEe5qpz2wbBQ36HNRnOq7MPo2zkvksacpQJwQ7hih9X5SGQk07fAmWMJrT0DWbaT+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790922587; c=relaxed/relaxed;
	bh=/3uKP316TAfLOs8D6w2CQrvf9oUDjp4A6r7z6eIgLW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iaPeOi+ETPX2DFrwTrlsYYgc4dnVXl9oqS9LCc7LGQ7p27+q9U1WvUUjifjZqJfquCytltmPs7f+Q89siZ3ygZJV+xsoodW+9KMc5naPDKPCOsZnJt4CDZczlfG3xfVav1R0Ebcg1Ky0nztlHJbrb526qjmbih5OuIhMdaGvH64o7XTORAlafUWtQcQMI5U00FKCV4jCYrIbIXkF+qZkj/8D8OAgW25K6H0I2jilcRd+LiXcbIxrCLegnlqdWWPmwS3nsi/hESHWaqu9buJm5oqTmODHOw5z/Ni7eZpPYzhztDaEBezqu9jyFJr/GOl5Ahz39kigRvBVePzEVVwwzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O1yHLgEF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::10; helo=mail-dy2-x10.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O1yHLgEF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::10; helo=mail-dy2-x10.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x10.google.com (mail-dy2-x10.google.com [IPv6:2607:f8b0:4864:36::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwzQx4NY0z2yDs
	for <linux-aspeed@lists.ozlabs.org>; Fri, 02 Oct 2026 16:29:44 +1000 (AEST)
Received: by mail-dy2-x10.google.com with SMTP id 5a478bee46e88-328664c2da6so6207667eec.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 01 Oct 2026 23:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790922582; x=1791527382; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/3uKP316TAfLOs8D6w2CQrvf9oUDjp4A6r7z6eIgLW4=;
        b=O1yHLgEFJTMlSDZeUhATesKLWuIj8618ZrecO5D75qXxsH3RNIxZF7Ih6XLN7Sw22/
         QW3CbB/jlE4Q8JW1F6k/181x4W7LtSUAHwbldNYP3Mn7HIGSRm2DT+zdsJwr09+3YvBO
         HHh0NGSnyhdlIfqbFf4kE/kXkBTzsDKdUgKr3/ttBfwkZoMjGDAcECtArJzQ5lZJqyWK
         9fgTw758UOsvUGUGRiaMKMghlOpxkIgBl59Sjt8FjeDu0WMsRGM+lGxnmjZb3FHzzqt1
         dWVsv6INfNtAsDXGQOJsvLHpKoFdbPvr2+r2vZLZJzKI+SoR6ya4zUqAr6fBeI3aO+v3
         sb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790922582; x=1791527382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/3uKP316TAfLOs8D6w2CQrvf9oUDjp4A6r7z6eIgLW4=;
        b=MmCXLmzOC0aWak3KkorI6NPMDpbJdqVajk/UT4mWG879lpTFTk9bWHpLuvPGQsXipI
         F+ZX8QiOCoy6Am/hNpYUwrV2VR9FgsAz6zLpxu35BWmbA9gTeRxBgLF5rnpX3l8H3eAY
         tJsEmyGjZEw+dv4BDQ5M7YvbovAQKW0cWwf9UgSOwxCQUB0u+6HPTYiZytcyI4RxMqVp
         hIr2Q71fkB4o7tTE8w8dYe795z4zBy9pN9fOkG9bf8PJ5z+28HmmSvD9w0G529fnnWAV
         QyGzbVLeDv/Jpw1lqx6jG8sXOlm4jD+iGlgVrwdB6M6uGjYaoGSWNO5ZS9HhJgJrTd2E
         KmEQ==
X-Forwarded-Encrypted: i=1; AKwUvBzPl7krQsXZ2sx8EEPh23E/DPRdmzItvWZD6SFSvRGc6W+QPlkDVUuztdrBCSh6kUlkt0Xgg9iIMV1PUP0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kRzpJIY0SrX7KHbSPO29LDItEScxVGZFKP6qEJNdNn1QPcNDmp
	hnBOCQreChIVi+wBMynBAiYwbVfLFGAZ5h4ux+uKlOKsg2ZYRxR78aWU
X-Gm-Gg: AYBFou0fqRgZfFol6L+cwqdSpNhpoGhxwlcPMQQJ+WJmyPyZURwcKIwShX5FyelOvHg
	BO3QdN6Fd+mjvY3UoyzBvDm33sdYorxePiLk02WbzJ5BsjBtRcpcOXMjBunB80NVEjO6QaiweTt
	krSlwRvi8XZMhiWSU61Fbrj46efZ5JrO8ttBXvdlJhtWde6Q7q1WrOWFxCk+SzlHhgBoRStKYeM
	5v9pgTLK7/OH1c6dPN6QO4iB4kSXyPuwNaPkLcqmZu37iKbdQ7glBChmtoL3bxGwckL7+d62dWn
	KoZa+WwwGIYLCHDMymP4o3RhTK+Q5RXXgOJB20qjyt7Ao4cbr+m2vSb2nqzv3WyOX5eIiME2epv
	1UOrUWi3GVsIjYXyuVc6du3h4t8OtZw839rR1LW0DhHGVrHrj3zRNK/Z+5OwqNrM1ScPM3gwlw2
	OXq9bUzuVJyxG8ZthjVROeuWIeMvhxw1qNmhTolxswYIVn09d+qMaPd18DBz2fwQa+Pn0G49MWz
	6ynS//A2DWlH91n
X-Received: by 2002:a05:7022:f902:20b0:14b:588b:c80f with SMTP id a92af1059eb24-14f5b026980mr1769046c88.10.1790922581583;
        Thu, 01 Oct 2026 23:29:41 -0700 (PDT)
Received: from debian.prasanth ([103.183.205.240])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f45fedd43sm6236636c88.4.2026.10.01.23.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 23:29:41 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v8 0/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC support
Date: Fri,  2 Oct 2026 11:59:31 +0530
Message-ID: <20261002062933.26497-1-prasanth.padarthi10@gmail.com>
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

Changes in v8:
- Correct the reported validation configuration.
- Validate the DTB with multi_v7_defconfig,
  CONFIG_ARCH_ASPEED=y, and CONFIG_MACH_ASPEED_G6=y.
- Preserve the reviewed DTS content and review trailers.

Prasanth Kumar Padarthi (2):
  dt-bindings: arm: aspeed: Add ASRock Rack B650D4U
  ARM: dts: aspeed: Add ASRock Rack B650D4U BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-asrock-b650d4u.dts  | 135 ++++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts

-- 
2.47.3


