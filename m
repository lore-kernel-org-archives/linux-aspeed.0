Return-Path: <linux-aspeed+bounces-2268-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EC9CAC59A
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Sep 2025 00:11:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRwz70WBRz3020;
	Thu, 18 Sep 2025 10:11:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758095301;
	cv=none; b=l1qIz7PtnMqgnH4ccmoKQ/cbryzsKQP6lm4GuC7O01TcFSOvby2O4ptOHJZtoc10HaW7Ux+KFkc5jNepNS7H7QxA7hDcs3CMTvXA0sdFKdNGuxehUgHbIvc92UN/n9iTF/HWvAiqTLlR4tplEUsjBAKcra+fNiizlxkV/eJHaIGZh/4dLpnxl+rDEAoFp9tVAIbqNxozQDFvHQ3gM40bsLB20julPRw/lfqm4Hofs4hXGtFO3kQBZp19R+zNOFogWNm4MRbrQyeg7/s44rw+DOwAPqw/REPcDdNojeJQu0OiUbGTMg5C3tE4TeIymw876tObN+2nusL5fPFcIJ50yA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758095301; c=relaxed/relaxed;
	bh=1JKGCDIkSDMV2O6Pn5OGiCTad+ltyhYyD3CS3WAtyS8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EFNF5zJzrXZuOX+BfjkQQzP7dVz/ZtuW42oE06X1pv4emsPYq/JU7m9l5nhL6fpkFfasU1zdJRRilzu9tmmqZBwlgjesjVl6LjR4M/vrZKrC2tQJk/IXMAZLE2LFsIhoe47YYK89wDfjtubcWvYxgbD8fJb6fMZwzikVUN/DV4fwx+xy2bdl/Kznq67NAizuxZ9pimLWZ6xgZ3f+w50nKxWcRVxAsqVSl5cNyknIQIkLGIMDHvxUEg4F6R+L+gN0dVSy9VyLBjg/qJ+tZb7iS9bY+9O6yx66LcBq+PcpYUA/qZvAtMjrAxhYnBjn+0GmWeII9wB3wahI6F7D41WOdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gQV8bXw0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gQV8bXw0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRW902Wclz304l
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Sep 2025 17:48:19 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-267f0fe72a1so8732465ad.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Sep 2025 00:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758095297; x=1758700097; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1JKGCDIkSDMV2O6Pn5OGiCTad+ltyhYyD3CS3WAtyS8=;
        b=gQV8bXw0fdhMQ/Ahkl2jydVskcxR0vG6k/5oCW9vHopR+TbKEiIjbSlyd/9aDusHGQ
         BVifSRnCRc14O0aFugjAvNN1ggSz6A6RA3FWlypiVi0p+QJe2ed+mvrdYh5YcaX38NO5
         WfpPTKeHG3ahRPyB7UcSAMdRXbe6i7MpqJLJrCEQmEegpHKSd1Qb+7XPDEr5pLGdwr5u
         604LHWDAfsE/Du5lccQhJvb5p73Mj1bYLdTJGauZx3RlLjyk4ocqttVdeurhn+s29Sgg
         +aeOWDgdB3C5H0GtNUFEbo3p7jl4pk8yCyPykdsz8VWHEOIqKlW/p/9TKGYbISPOD9xc
         l/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758095297; x=1758700097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JKGCDIkSDMV2O6Pn5OGiCTad+ltyhYyD3CS3WAtyS8=;
        b=ABLmzNudlhThFX/LUYNF3C/NXSXx6JEXdJI1HJ0elidGt3kBCARxcJDpcSgxdpGO4D
         sAxuxF6d8PO7Dm1lKidQ16JWFpeLt+CHEG3ajiIa3TQidQGR+lI5h5gODyZ/jU1L3JA+
         mWchgswOl6QurdfFLKMIuRjMrw4EaFkulPG/9HOGBRXB27uWzGl6Zjmh9FD2wxiZiI+h
         HgmUyPgunJ1hv3JbKY67zdd7sv4sl79HdLw9rwbILNSHT9pSP1hoz+anjmBddOs/r2qC
         YYngiG/lvhGR8lyt/zXBqPZeVTRASpYa6ct0hLHEfuKYCC/DX8voc86XiNauKlDH5cws
         pwGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyfob3qe9XWnKTOe1QIJmkZI8L9YGg/GjrWx2df1+NMRbvZ9kpIX8PRYJgbgpsozrpsWPF0ys03kHnuOk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzooSFHhoKK4xkD7m8NpIRSRi2NGO8FsIHvHaZOeqA39v4R/l/6
	rWOxG+mPkuE7FqQZU1kUVPVEoU1dLPbbuMADUS/3c3SBwLNIXsOkZTSU
X-Gm-Gg: ASbGncvrQlQ5ELRlD32fCemVRlRJbgd7E9Mr54m2wFtfijQT/m52caqI6zld7e1fu9R
	iikwrrYtmpURHn2BegMQcD4cwUxJHk8niJ/vRtgRBnMuFtGfEYIRlsgc9gq1XWsmuoPCfPxeJf8
	bS1mLG4otrT/YFfmZ5Zoff17elDwN3iqU/5TWFIQpfwrGXFjE6EXtq/1N1Qr5aalbwvu3T83C6X
	NgHtmeavyrTfLqEUGUBOiNqpmRelYjMzINDNwvkhHEf5MlmqaEqtFwx2buwL/9wcxHlOzaTZBMz
	RxY9uV0hVTAVafPTggUDEzz8OIe+puxqe4Ndtq41rBCELXUWqLwF8mGifxzYl8+EvvcAMojDbVP
	KNrmkbmF5MiFOxsAahFnLm72l70iNEkUnV1RkWWfSEArYWUPL/B1aqPclFNzaJX1FZhkl2cHDyT
	Wlz/tRhj/6CT9b5ZMO/TTjq2jmXvqy1xJoFt35rNTgeA==
X-Google-Smtp-Source: AGHT+IF3iFCqidqJcvK/xXuEBMbUNqvYtrcapIiOCibgP1M/29Qz0m2dsrVVMS/TbfoPK18iCzQjMg==
X-Received: by 2002:a17:903:19d0:b0:25c:25f1:542d with SMTP id d9443c01a7336-268137f2336mr13981925ad.36.1758095297176;
        Wed, 17 Sep 2025 00:48:17 -0700 (PDT)
Received: from meta-device (2001-b400-e359-6d3b-3881-d7b4-5e6b-c23a.emome-ip6.hinet.net. [2001:b400:e359:6d3b:3881:d7b4:5e6b:c23a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267df817ef5sm34796585ad.0.2025.09.17.00.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 00:48:16 -0700 (PDT)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v1 0/2] Add Meta (Facebook) Yosemite5 BMC (AST2600)
Date: Wed, 17 Sep 2025 15:48:08 +0800
Message-ID: <20250917074812.4042797-1-kevin.tung.openbmc@gmail.com>
X-Mailer: git-send-email 2.51.0
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
Add device tree for the Meta (Facebook) Yosemite5 compute node,
based on the AST2600 BMC.

The Yosemite5 platform provides monitoring of voltages, power,
temperatures, and other critical parameters across the motherboard,
CXL board, E1.S expansion board, and NIC components. The BMC also
logs relevant events and performs appropriate system actions in
response to abnormal conditions.

Kevin Tung (2):
  dt-bindings: arm: aspeed: add Meta Yosemite5 board
  ARM: dts: aspeed: yosemite5: Add Meta Yosemite5 BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 .../aspeed/aspeed-bmc-facebook-yosemite5.dts  | 1063 +++++++++++++++++
 2 files changed, 1064 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts

-- 
2.47.1


