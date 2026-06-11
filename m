Return-Path: <linux-aspeed+bounces-4242-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0203CCD98D5
	for <linux-aspeed@archiver.kernel.org>; Fri, 12 Jun 2026 00:11:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc0Ks3YYTz2xl6;
	Fri, 12 Jun 2026 10:11:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781201338;
	cv=none; b=DwFyPFQSx6iWL2SdDa3TWzhQqewNV62yzuxZyOYOCCbjnqAQSd+3Y9DQNnlsTb61SPD2OsyxgfmYxtQ92+BjplgG6yTTxR6DhOqrvWm2LTD3iSmP+wN4LM5K7BISnXoDdcr+njW1AFALJDJyC17xC3DUDvnJcnpmbS1Rok8a/sgAoY2n7jTCFPUTqqT6et6r55J3NQ5nEY7aRmXOG3xBZrvK2FZA9jObPQvafOD/BlU7GpjXGGhFy9YgwGdj6GA7rdj1d49ZTuYLl+OMtK0/NluDCLTA4AaEXbu9zA8DuZtT3Z/DSacSGxJVY7s+iONxiTNevqsYya6q+FwMIzkpZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781201338; c=relaxed/relaxed;
	bh=pajLU4q8bCN5YoHUmk+hCyhoUL3rH3RIe6W8LPCHUfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jm/JqTCaC0d8ZI3Gp0CXXIR10qCmQMQMVblwvoWBiOQ6LdJ/fzIvdw2A0ftcc88nRngrUr6Rb69ZxO0co3RwVadzif7SoTTsWpX4rtzYh4Dy4Bh8haegd92RD5f7HovY73A5AnD8lElVguQuV339W3mK06LKyC9U/gk/BPCdcH8CR8Rbl6/s9IBDmrnBGuEqO89dupIyk9hiE6mXOYQ9AFo0W8KV5bOaDXgWwSj+E3RnyV/5gQPpvCieCAy9zsJpHGZVnx/6LqWQJdEEz3qHePBIYUc2r5BGy/o5DgZ3B2CUAoQEKzoTmQLWUCNPSP//+C5F3omHFoV4tU8txFRpKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mEtiL4wz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mEtiL4wz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbrHs6Bknz2y8h
	for <linux-aspeed@lists.ozlabs.org>; Fri, 12 Jun 2026 04:08:56 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-36bb3551f6eso230417a91.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Jun 2026 11:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781201334; x=1781806134; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pajLU4q8bCN5YoHUmk+hCyhoUL3rH3RIe6W8LPCHUfg=;
        b=mEtiL4wzcEKs9tIoguQXOug86WdY65S2lFZZz545XDJkUwq+mnW0d5caMKKdDK0nMv
         ajDkEj5iBTvryYpwdSsVeOHYbIChrCk8SWD6swbtqMk1363ij2/KwneTzAhVMGB5BKEl
         ezzzg14EMbEnTAlfqY2X1On9DMIrSs+nWej74avcskJgIoKsLIgMQp6EIEjxVItvB0wx
         fsWv/g8xIILmgDpN75uIqRSovBBjNZQlFb7PJX4JKw6UYnvqzJ/fEmSoGSvhucH0FkG2
         VibbScz1/6zPBq++PNO7TAcN1gsGFKeXSh6IjROcIccyeLjZ8eYPS/Ppmd8MTSy2CiVC
         2u7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781201334; x=1781806134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pajLU4q8bCN5YoHUmk+hCyhoUL3rH3RIe6W8LPCHUfg=;
        b=U9yFBo3OxrfoEz1eye2q1MC6XQ51OFchfWtJN7hsyD/D4J818gRVfEAJBs7Lk3svKg
         1Ar6UTY591RhOB1q7G9xceMJnAt1ZNYtCiERl7nat/OE163fn52umEdaNEzhE57iJIh7
         V0bkCrdaLUi7ApmtMDcmbzYE+Du2L8yN/T4CNztGB/dyyntt2Cva5ABC6YN4/CDir/Y8
         q6/wLdHwcV1gw0nx+0lrZvxOEz13ez5zYyjWCnYUMn5+TTebJp7YoY0JZldrOe55msQT
         vLR7ecRlZ5I8j6L1uT2AsQJsslZPT9SntcEo5sCZqmh9wNZuyOIbzossFyG0+QJTuNcC
         Zwuw==
X-Forwarded-Encrypted: i=1; AFNElJ+eC+iN5NGL5usBfx44KUGTsHw50ppOa3LPzQaTUwjW+QpU4dgBw1AWJ9ZIpDKN749pm5ocu8RYqJ9LAiM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwNt4Y9Zv7QFE4gVFdAwcWO+mZ05yBDsy8+VWLnGuzLUAEPaTWm
	eDINxiu/DWxatzz3C8nSulsD/U2ljJHP0Fl1WU7LL7PWW7n4GjkfLS/V85rJK79g
X-Gm-Gg: Acq92OGMoi2DY986+Vl3WDeHEoEcGg+cKnqLMw2vHUG5i9mvuBcB+P2ZzrE1KVYG/w2
	d0JhWGoEE3KcNgkAGKNKVpuc2I6h+C/hrVwZRsrk34gZ49TMzhuc4sAi7VPXAL2alDWnMaxv+4U
	przDaRVwRiI/EXsPssVXHYjix+FxrR614npDunjDZa5nEgJy2b0Cnn4r/zQJ5xvSGrVmNhwg3ro
	nBmI0WKL3O1BzdMY1gd2BAjm3FymqTN/UCrv8c51pBJyAFPwrTRL69EJeRTNdBUxzJzyWRsuHLt
	Kkr/r0rgPUdWiH1TAoh/HDZkJvFwJVW+c5d2QnjwGEkyqmUxu53W6IncyjFdQRPZt+lmtpQ6E2E
	0hFN0nSR/BTRa1d5GMKKluoc0F03W4PBm7gp/fX3iLUl+fRkn9LnnK4J1jNG72O6pmxZjobWIXT
	zFWdmFF+y+Q+PncGt1Y7OIe9bjCgWsWBTAR4uWGOHgdoq36z/Kns9fYNvf
X-Received: by 2002:a17:90b:2dc8:b0:366:10f1:3d86 with SMTP id 98e67ed59e1d1-377aa799f69mr5239736a91.22.1781201334232;
        Thu, 11 Jun 2026 11:08:54 -0700 (PDT)
Received: from LAPTOP-97G9G880.domain.name ([106.222.202.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37752d59ff8sm3256230a91.8.2026.06.11.11.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 11:08:53 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: andrew@codeconstruct.com.au
Cc: joel@jms.id.au,
	andrew@aj.id.au,
	Kees Cook <kees@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5] soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read
Date: Thu, 11 Jun 2026 18:08:45 +0000
Message-ID: <20260611180845.6556-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
References: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
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

Hi Andrew,

Thanks Andrew. The __guarded_by annotation and context analysis integration look good, I wasn't aware of that infrastructure.
Thanks for applying the fix-up on top.

Thanks,
Karthikeyan

