Return-Path: <linux-aspeed+bounces-1171-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9BAC369A8
	for <linux-aspeed@archiver.kernel.org>; Fri, 11 Apr 2025 01:09:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZYdqr0FS6z3bh6;
	Fri, 11 Apr 2025 11:09:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744333751;
	cv=none; b=d/ZF97rC5rQzHOamHwUeYSMyQ1Zx5oqk7GdlB3oELwWMx4XAL5AJ+NxF4i7OFyq23jgTs4c+jwDTiKmJLAbb6KIALn3UohPUqd+nvJ7AEygBYMU6SCtuCEt4eNNevuEst0w1Zxen3FX/QUGz7bz6rgk+9cs+LF83S+ivoiu3ISC4HCDrnAFFpa1iboE1m/beyhZ03na1y1ejF2cOLRv7TWGRlsvr2tSSQXGCD84xQ0ADsE2ehQi4xyIsTe9A6RXI9JjU2qeTpTo1GK1WpPo4ZmfGLckRsl55yCb0Li73pnUjHpGzYBWYtGh4Pmr3kODPc6/bFV6QioEpWR2AEnLTvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744333751; c=relaxed/relaxed;
	bh=owww72mo7rRa4HGyljLXSQgsg6KGAlIxseqdPKYlAm0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J0wrsZA5ABD1qNzW+AArPQTqRsKZw6wcxfQxLX7sBQrJykkLTH9Cmveswvr3qHzPMAiDRtHBsoFjo7BNKXBdwuF3GoGpVhi4nguQW8/sP8Q2zuoXwUaYdZTfsRkGs7btM7Sy6cLbtDTW4RfaRv30znYTVGsh1qjNMh2A9Ar0CfyyMrHZxC1RF935tovX8AwKI55PBVkg4DWHOodjb9DllvMlKLahrtcjaaFUhFXn4D1KquVq8bgrZw9Mt89diohy4hskdwKM6AqAEF+dSvXD9e0TfVWzVegyaHmZWt+VqrjshN/hMRQ3LAzOKSqxz+yVF+haC1VjKDrPwLJ6pfzaWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=XqOdX6U3; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=XqOdX6U3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZYdqp32vtz3bh0
	for <linux-aspeed@lists.ozlabs.org>; Fri, 11 Apr 2025 11:09:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1744333747;
	bh=owww72mo7rRa4HGyljLXSQgsg6KGAlIxseqdPKYlAm0=;
	h=From:Subject:Date:To:Cc;
	b=XqOdX6U3Cq0OakPdb4QSUC556jn3yncHePtbEtu0jYQLrwHC7TKOeZ0RPYiMGHHvW
	 TN0bxeNNvhlBtp8tXolu6w0pxB+HhyYZ45q3WtAOZW5BZTCpFjl3cIl/AImVPxYzBY
	 +tf2NTr8dXALLFL4N+70njc+TxSuzcXFxRqqHgp+q+hm772phcDm4IBaKG/iKOJj6g
	 Jys/+azHbxTEL3e+t8R5XJN3hW1BGC7ea8rXFNmoMAGI/l8iu5GcSCuTHE4FaW9AIK
	 fn07ZDMEA+xhsjsK2Tw8+Pn1c3SciinO7Dkp1vZnUNujcZCmD1vgZUjxMVbdgD/dQJ
	 hJYJLUonN45MA==
Received: from [127.0.1.1] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8D5237D705;
	Fri, 11 Apr 2025 09:09:04 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PATCH 0/7] soc: aspeed: lpc-snoop: Miscellaneous fixes
Date: Fri, 11 Apr 2025 10:38:30 +0930
Message-Id: <20250411-aspeed-lpc-snoop-fixes-v1-0-64f522e3ad6f@codeconstruct.com.au>
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
X-B4-Tracking: v=1; b=H4sIAI5r+GcC/y2M0QrCMBAEf6Xccw/SxELxV8SHkKx6IEnMWRFK/
 91DfZxZZjdSdIHScdio4yUqtRhM40DpFssVLNmYvPOzO7iJozYg870l1lJr44u8oYw5+2UJOYY
 YyOLW8R2sPZ1/3PFY7f/5l/v+AWm6cWJ9AAAA
X-Change-ID: 20250401-aspeed-lpc-snoop-fixes-e5d2883da3a3
To: linux-aspeed@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>, Henry Martin <bsdhenrymartin@gmail.com>, 
 Jean Delvare <jdelvare@suse.de>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Andrew Geissler <geissonator@yahoo.com>, 
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>, 
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

Henry's bug[1] and fix[2] prompted some further inspection by
Jean.

This series provides fixes for the remaining issues Jean identified, as
well as reworking the channel paths to reduce cleanup required in error
paths. It is based on the tree at[3].

Lightly tested on an AST2600 EVB. Further testing on platforms
designed around the snoop device appreciated.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=219934
[2]: https://lore.kernel.org/all/20250401074647.21300-1-bsdhenrymartin@gmail.com/
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/arj/bmc.git/log/?h=aspeed/drivers

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
Andrew Jeffery (7):
      soc: aspeed: lpc-snoop: Cleanup resources in stack-order
      soc: aspeed: lpc-snoop: Don't disable channels that aren't enabled
      soc: aspeed: lpc-snoop: Ensure model_data is valid
      soc: aspeed: lpc-snoop: Constrain parameters in channel paths
      soc: aspeed: lpc-snoop: Rename 'channel' to 'index' in channel paths
      soc: aspeed: lpc-snoop: Rearrange channel paths
      soc: aspeed: lpc-snoop: Lift channel config to const structs

 drivers/soc/aspeed/aspeed-lpc-snoop.c | 149 ++++++++++++++++++++--------------
 1 file changed, 88 insertions(+), 61 deletions(-)
---
base-commit: f3089a4fc24777ea2fccdf4ffc84732b1da65bdc
change-id: 20250401-aspeed-lpc-snoop-fixes-e5d2883da3a3

Best regards,
-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


