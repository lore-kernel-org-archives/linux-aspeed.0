Return-Path: <linux-aspeed+bounces-4124-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12029CD5BB4
	for <linux-aspeed@archiver.kernel.org>; Sat, 23 May 2026 02:30:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMmN441dHz2y71;
	Sat, 23 May 2026 12:30:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779503444;
	cv=none; b=J5RYg+vZgiNFPpk799EF5kqvUX5bTsuHiW9af9ybkFNAs5zj1S47KTNuMpTpy3Wgo8b7Vn9NlAoXNw5KAb7KSbXDH6Ab1stOz88x335D9sfMZnQkSoAei5AZybushRPa21y9dD06awGgEMJV0R349yiuvyg6j6byIms9CYzT3DNr8Dfo2Vcc6PVuZUDZgdTdiMhOF2PMaucs+iODuT/MiTytDohTpa2TRTQY4GAKrLt5RaY5q54CpH4ZzgTu0jKkrjyJC3gUx3SKbVFTRIfOuhfQuZQvKWDlR3pHT6zchUsBgfeXAOsomHlbpc0JLTPotzZH1L6NCOMhOmPDs3465w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779503444; c=relaxed/relaxed;
	bh=rH1cdqbeUyBX+hi3A/hkyAkrMLwhGxYZ5fPk7KzkHV4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P1mhNqAT8aLQeA2+UPDypSTMlua64mgz3itjjlpffklnaD7gDC4n2tHNx1OGoVFTQmsKn01Swhdl1XEKMBBrZcbb/moKFhkvcgIkUdGXETliqucGjfMqaoEOi3tZ6uYRt0WfMFULTOowDxKMIso1Z+MdIpGPfvtK2cSZyOTUExsUNmFDAQ6QeEX7EFcTcDMeKyQrYuhGJg42zFksuMPG5kMROLQ0OoBRvWa4gDIxQITO+1fEPxWz1dxlxH00AiIQnnDcDOHiWkm64KZ6EgZA/v/0hFEJRB07rWu4UJtgUSnS/PGi+C/9APaJe6YM1eY0rLZo/LerXFZ9eHs7k65BmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gQfym4tM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gQfym4tM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMmN30kXTz2xfR
	for <linux-aspeed@lists.ozlabs.org>; Sat, 23 May 2026 12:30:42 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-36931e4f5e8so7087797a91.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 22 May 2026 19:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779503439; x=1780108239; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rH1cdqbeUyBX+hi3A/hkyAkrMLwhGxYZ5fPk7KzkHV4=;
        b=gQfym4tM4o61feNBRHTQ7905IQFnL6bivXrjkDqUTqr2PnLFzKWcMZ2VgODJ9q1mi7
         CpWYQX9kKMgch4ppEDrIAJfDAxLG6mD9fZeS0EgGQEW3d4rhetdGqZVse/zyarKO+1I8
         7dYAqfwp2ebRuM+m6Xji/kAz3EA3F+S6k7F5p3Ae3lexjkZ1jrOz/7hTGglWGOOXKFny
         io7Imqe5LX6RKQPLiUKMn8Y+OnBY7arOFCXZNuo/m1BND/JPqSo5Vu8/TaHulGQr+lMP
         bHyxU811Vyh3rmTjv/TtConWsu9RaHzFUgPncA/GXznjItyZDm6+ky03UE6M0iCg/eUF
         q+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779503439; x=1780108239;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rH1cdqbeUyBX+hi3A/hkyAkrMLwhGxYZ5fPk7KzkHV4=;
        b=b5P49WslVQehVRbmzk8S+FiOsyIwAnSmUJlNDMcGkpqx4QkC1gE3nDvGKPjNHnE+lc
         faAOGF9ecgFH4AabLhf8hIQmgcWn9BYMrhVSchRnM8XIsLLQRl0CN2EpQ9LR58xjZCL5
         kQgPbEUqjmFyATBhDFPNfLofmvYbAeRL5TdLTAZnbamDO50e17vxt+DohSFWoer4KR1s
         3g7LprzWlKq57Zu6QcyJfBD0sKzg2MBNkWWmWjjmANEbfmjtwfm1hTWTelNwI1NkuM/0
         pmdCuo9JqMoEAn5T2ViMHsCfum5uj8Qr3EEpSUki50u2jdHvEtiVbMWDLzFUvO9BLOQj
         2emQ==
X-Forwarded-Encrypted: i=1; AFNElJ/BwcgYWQHCdL45P/yrjwsONFMS1zk+91IGBYSc6/OGeYaoVyXZK9yUq0uicxB126ldLwX+0VsCyxr9G1A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyn399Om54Ff7wc2NggkL/PNkZa7onfYPBekmmwCK385usK91D/
	+c3JT5XvEQW+7+frsiHbiGlyAL51WToQ2qOmyECcFyObizH76AeWcdcC
X-Gm-Gg: Acq92OHwVL1ov+yIjsji0Ms+7EpmbfRvAwX2n3l7CADSES9Ns6a1sgtJVgStOYdUQ+y
	uiBqSFgHS8jP5WN49Np3L2Y2RMXv8W+q6BbwwO2QBQ6oVeSVxk0LKoaNCMC5dFSuasKt51uOM+e
	pMozc5vEqrJ7vtMpaM52x0b0f2ZBvrqD2thxnSIl7exvJfIUdNhn//NHAESSbgsq5xKkIjR4UV7
	K3lBtcoXhow/0ADE6DhC4BkOYkhk9UXPC9Q/qPwqDqktBDfTrFZ/a5b82iTEsFdLyGjVTFwT4tF
	H7Fs2QJqkMq4wfQDm9HmgWOCim6nmKZ/k/wYS/Uxrxw5jBYBO0x7tsV3wbi6Ucf9bxayjCm1Vdq
	gJcfkEqzI+QjjK44stBJe1YMHR1VwBZq1prmr2J8CoXbMMwMAm72u9UzvJaHtnE7+ICemhpwdkK
	CYyoZKqIS4k/mUYrUJZMxcxfqiNMAtDCKCe1IY9tR8Cys3gZgf85yEegOgwQgYFfrfFA==
X-Received: by 2002:a17:90b:3c0d:b0:36a:95c:7603 with SMTP id 98e67ed59e1d1-36a674517bfmr6928855a91.10.1779503439092;
        Fri, 22 May 2026 19:30:39 -0700 (PDT)
Received: from [10.10.15.228] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a71d944c4sm3010287a91.1.2026.05.22.19.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 19:30:38 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
X-Google-Original-From: Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH 0/2] ARM: dts: aspeed: sanmiguel: Update DTS file
Date: Sat, 23 May 2026 10:28:06 +0800
Message-Id: <20260523-potin-update-sanmiguel-dts-20260522-v1-0-169f5fceb5f9@quantatw.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALYQEWoC/z2NQQqDMBAAvyJ7diGu1IpfEQ+pWe1CjSGbSEH8u
 6GHHgeGmROUo7DCUJ0Q+RCV3Rdo6grmt/Uro7jCQIY68yDCsCfxmIOziVGt32TN/EGXFP/O89U
 66g137dJDKYXIi3x/l3G6rhtsXjgddQAAAA==
X-Change-ID: 20260522-potin-update-sanmiguel-dts-20260522-7b3d280e63f8
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>, Potin Lai <potin.lai@quantatw.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779503436; l=646;
 i=potin.lai@quantatw.com; s=20260522; h=from:subject:message-id;
 bh=DXGVy7z68ffl9XuZXM958QsYAFSYqNBt3EmenGJ/gA0=;
 b=R+4jpOTTnCHIjRDFt3jsWNz4H5AaeSg3D5NxXi1qN65cyRkf2x83zzgNwaOrj9YaIr+0DG4bb
 77hLMe0bxoeAXbacXRdXx9Um7a7ZwiTemNSr3NR7zLVBPjuPalLHF7v
X-Developer-Key: i=potin.lai@quantatw.com; a=ed25519;
 pk=j3/nMxzz1ZPpp1revghyZ8IqOnwi6RWfuxXN2XrNMRE=

Update the SanMiguel DTS configuration to fix incorrect GPIO
linenames and resolve the IOEXP interrupt handling issue.

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
Potin Lai (2):
      ARM: dts: aspeed: sanmiguel: Add IOEXP interrupt pin settings
      ARM: dts: aspeed: sanmiguel: Fix the CPU_CHIPTHROT linename

 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
---
base-commit: 6e22b9e818d68d7b8ce6680aede0c80a9355929a
change-id: 20260522-potin-update-sanmiguel-dts-20260522-7b3d280e63f8

Best regards,
--  
Potin Lai <potin.lai@quantatw.com>


