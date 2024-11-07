Return-Path: <linux-aspeed+bounces-97-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1ACD4335C
	for <linux-aspeed@archiver.kernel.org>; Thu,  7 Nov 2024 12:42:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XkhYG4TJWz3blH;
	Thu,  7 Nov 2024 23:42:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730983346;
	cv=none; b=LQ1AqRo29i4s8XYxcYUBadrPAO4vKU+c1jwjyU3sYQIrRBUZfh1gVdc3hOnHnq+8rT8puX/9+YzqEy4HgWAWbxRdSOmQlxNhh7kL52RXyPZEGZEk781oQGTj4RQowlQQPMpQtW+gSqa7VgiNUfCuLH9x1fIKVH1M0EO9fgoMdNjGAP3CZO0UTGG6/F3XoSWp0zLQD/pK/BSACQgvZFKD07pNf8Wb7HDtJQNNpSJAbxdWKeKvi0xpeAhAJNL0ROd8/W7dCe00Hcrb/Wz0bmrWyPVHNI7Nfq5GqC+ngbgXIaAGL2Qq0J2cFpyU/fyNdK/JMS2VfqcOUNPSlDZCPn0XDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730983346; c=relaxed/relaxed;
	bh=youLRMmo0sKknJq3kY6wxMpo14aMmgxOgYUVVaBBx1Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EI5DCX7ljnbjDwlnLI63lSK8Kt5m0xBQT5JUOdBd90xhBpKypkZb8IHfdJDK6DVH1s87zmatap/DH26vrpZTBR1N/MPyEkUAKW+0WbdhuvCweO33869OmXBdLo1qhmsMMKh1CO8xj8JPTMG3896lryhLdeM4/rZ5K/rPjpqPiqQZwQXxn6trzy+HCeQu3/nFUX8Xpr020yRyOoSSDOq1/LZvj4jkMQ7BZuv84w4w7BL+LaA/t3rcwcdUcqktZuO8Tzh1VaSP+CuyLstILUdGCX/8t4UyX+Rzmx0AXnhDydAX2B7BdlmfYYseta12e8BnolcP1IDCYwEzYfPqoMxCIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Yz5V14sj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Yz5V14sj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XkhYD37WDz2xYg
	for <linux-aspeed@lists.ozlabs.org>; Thu,  7 Nov 2024 23:42:22 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-20cceb8d8b4so6120065ad.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 07 Nov 2024 04:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730983341; x=1731588141; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=youLRMmo0sKknJq3kY6wxMpo14aMmgxOgYUVVaBBx1Q=;
        b=Yz5V14sjfgKgesmZOFa302P/FFn3YhfNSz5FnKf7HZnYDC1P/nQ9yBCbl6o7I+r43g
         cqF+oNkOGqf/6XFV4mp5BA+XGQgVxExH01PnjgjWdkogHomvtCQlpdSihIyszSl8h7Tm
         bV16AwsD/hvu6jSCys91Kq5h5wMopVcfv2nYHCa1/2DmDRobGtZpgepU5M1PYURdO20O
         WSBFqp0hrac6zxVvmMk6zWhD6RwxT+jOdcDX//1iDocsFNGpyHUMAEI7863UtVm2M9Za
         QbM5i5BZNJzqxjLhJm0ERLOjGPRgbEmN4lepInU9sEPHj8pdPX6Udv7MkGSm9pAKqVx/
         6Y+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730983341; x=1731588141;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=youLRMmo0sKknJq3kY6wxMpo14aMmgxOgYUVVaBBx1Q=;
        b=wNyrkMZ+vfa+iEMLFMW/HxB2c4008oqP9bpVq4xcnUd/F6FyUX+p1+I+uTniB1mSUe
         89eiPr3RIcFwUsVduAYCys2+2jpgcW162EBrcCSQfk1ComKHVUJmz9Y5Jtw1L175P77K
         PFOwg8xKshrNRcArlLMv+4ugCzjv3w5/zHj0pOw+cQCx275mxJyrXQpZYrKBN0th+uAr
         Q71AzGx53q9nTs5vCQhrgXUitrDbEvhV1+45aaJI6aaG9xK4rp9NiwtPz8KHFYGQe1t4
         n8HrbATwyVxwH3hgXMHI59u9TYz0JQOARxZnXaihpvCwPjjeLw4nSdYdleGDePOeBhPv
         RX+A==
X-Forwarded-Encrypted: i=1; AJvYcCV5kJHsjWMDcRHTPRTFqQ6AgFPzhmx+U5O2z6S90qEmUePHEFCpDGffPurCBMXmYRVfaHYQQsiBezNapzA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzY0N2X1tKgUPkR3N/LuSJg0pER/ZTqxDNd+FF6d9QIZ+lLM5Ne
	nlPfSpuY3Hbya6C7BjDSFjURllQ5QMQTBZXErdzQchv+MPGmtj9K
X-Google-Smtp-Source: AGHT+IGEXo60WK+bnzWKZpp/tb3i21nIWbMBqygL8tAiAdUOQebmGHeK1uuGJEibdV7evN/corYGzw==
X-Received: by 2002:a17:902:d48b:b0:20c:da7c:6e8c with SMTP id d9443c01a7336-21175a93c02mr52725505ad.3.1730983340762;
        Thu, 07 Nov 2024 04:42:20 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e412d8sm11101975ad.113.2024.11.07.04.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:42:20 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v2 0/2] ARM: dts: aspeed: catalina: update CPLD IO expander
 pin definitions
Date: Thu, 07 Nov 2024 20:39:56 +0800
Message-Id: <20241107-catalina-cpld-ioexp-update-v2-0-d7742eabc0e6@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIABy1LGcC/43NTQ6DIBCG4auYWXcaQGJ/Vt6jcYEw6iQqBKyxM
 d691BN0+XyL99shUWRK8Cx2iLRyYj9nqEsBdjBzT8guG5RQWkpRoTWLGXk2aMPokD1tAd/BmYW
 QNDktHkZ15CAHQqSOtzP+arIHTouPn/Nrlb/1r+wqUWCpy1trO9tW4l73k+Hxav0EzXEcXxrhO
 nXEAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai@quantatw.com>, Cosmo Chou <cosmo.chou@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730983338; l=783;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=fDEBLfyJb9nAn3ipO12nV6wnAto2tMxREdWJ9q5mc7U=;
 b=EKVMgmy3zl5agoZHAZ4L/s+CG8X+hFuX+tTz28Z0g2vxOKOPzhCqGMqrJw48x6vluGrArZFlA
 FR3h5HtOXxxBC6dMyMqO51uFbZ63ua2/BTAb8HexQTzfXHtdyEkt81E
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

This patch series updates the CPLD IO expander pin definitions of PDB
board and HDD board.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Changes in v2:
- add more description in commit message
- Link to v1: https://lore.kernel.org/r/20241106-catalina-cpld-ioexp-update-v1-0-3437bcfcb608@gmail.com

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


