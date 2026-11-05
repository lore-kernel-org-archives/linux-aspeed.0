Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A498606A326
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Nov 2026 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VQY9vFS+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MPMqS9cS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLHDc6Tbzz2x9c;
	Fri, 06 Nov 2026 09:34:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793869999;
	cv=none; b=YpES+c2cpONWsIacX1nmfzvX1hJYQkhEsxQgNJmyEKmIeKg/iQIT2BFkwrmLCjGiaQQMDHBk8wNt9oPVDlEXw9ZQmqv14KDXVDkA2t+0oj/yLVJ+ET4hzpXuYmOXaId1+65z+nsfCDmEdLpUaAKxdIVvmH++jSQIGZV1bOvs49ksQgs3jMHIR0CfysXXlzivJZjnPVXg31zwtXCXnDzm0R8VqGENQ1bwWZNPo6Yd0oflx4sJTIsq+c0UPYKbHcsXcVcbb7A7pb2iAMk2zB2dGBwDXdsy7URmDHcOrNDE3ni2GjZhXkMMyHM2I/UJQ3vUzixkhZocYgNJn75VL271KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793869999; c=relaxed/relaxed;
	bh=q9yfY+/I3R7K6u83bmbStsO2lPmehAVb28U13aAr0q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TR19ENL3cxOqtDls/ZxLKpWD2TybwipZAAfbIWTZqzSlushXgUOS+eE+ILhB9K/JFwC7N30arkGIQdfwGQgmj5l848HVBjbGH1aloizKav09CCyNmpSRAXvB6cf6DOv4+P6INaXrmdyS4xseGnA4dnR9ECfi3YpxXq4wQzRvwRwM1ci9Af4jPKiLimKfvGpoS4ujDkImBs3qqSskHmif9oo/bCLbCpK16UBp/u4T63PSc/l/8PUbb52lzRS+nNis6gVRWQtZ96CM0s4rxitrzeVpauV5XWE+u2kWfsasbY2qwgJSFyYYyzXzIFDatnT7NMBtqcHUdvPPQw91TFGabA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VQY9vFS+; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MPMqS9cS; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VQY9vFS+;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MPMqS9cS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKxRx4Py0z2xGr
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 20:13:16 +1100 (AEDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A58RQB5247869
	for <linux-aspeed@lists.ozlabs.org>; Thu, 5 Nov 2026 09:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q9yfY+/I3R7K6u83bmbStsO2lPmehAVb28U13aAr0q4=; b=VQY9vFS+f916fsBm
	rX3P5iE9IbgB/XThZDvdwekJ7uK6K5qkEEV/GOdy++Ybca0QLidKN3svnWQjIFuL
	e/sz8tVl5tbtUIEcZ4UNlG9au0DU5Kmq5aXsfIGhSmnn1vDPZ9rHxjUgt7uxhmGz
	vpJnyA3qo4Cv5bY+cZ0xVctvGrEbRZqgPWkyC0hVrK8MJ+Q+r+zejMh5GdfyPxCm
	g65/vC6yBgHSZByj+mjuZNByeCLUy49DmrLweKGzv2YsfzeLxooAvVsa/GMa7s7m
	zZfgkrDd1yaAEHWh+P2wJ+7/VkdCuHDoQx/CT0BKuBKe3D0mnR+aXtr3FqAi7tsx
	i5WkEQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrpaag66y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 09:13:13 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9907539aff7so1158767241.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 01:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793869993; x=1794474793; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q9yfY+/I3R7K6u83bmbStsO2lPmehAVb28U13aAr0q4=;
        b=MPMqS9cSeKHXr4F7oUdsvpgRvFd087GZGmQs85juOJSMC5/oPWPCrLZ48+HTIOzPga
         ZBOc10f/CasXvCNHOsbGa1gVdsdqvO0CUknZ2s/M5oA3v6wYmJBlLiS/kiBVOjoP/Pme
         8biQBIpLW39A/ShBucrU3VZabQ0109bzYUvM5s+Ut9sWpmKcTTFITabJzHG9b5bRs7Iw
         NRL2qMRdk4JepIMt7Gh79TG7uDs3DLMzgg6aCg1DmJpdPEKa4caWE1Ns484Ayj4wUxRO
         STS1Xpx5sdfhst12PtMfuNLHSVqq//grikjHD1ghwbBul9g+v9tTL7z2QOfnZhQaXPvj
         9gYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793869993; x=1794474793;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q9yfY+/I3R7K6u83bmbStsO2lPmehAVb28U13aAr0q4=;
        b=fN8cSnVozvqo8TVAvlQIZwULFuRyVKcO9qVa84iI8Njsz0WW9D086/dVM+xYfhC9uk
         aoQr11yvabg5jd2/hVuKTTXMjk5wb4ErpjBnJf1DsEdOFx3mU+E5n/2LatwMH0SjHK2C
         Z/WPDk6ttwaN7b4I8Vts2Z9lH6a5Z5jKLr1pWEpNy/USTEVND858kIDYOiX/StfF03fc
         adoqWxKJ5vucdu+sQeeGgjgewWMFcPDP56cKrGAGUpa7+6Qj7V5MFx2TY0lV/3aNX1tU
         ikqn2Ekc65wYcCpkWtiEKCeKNN4lQhAuqrlgDlYCthmHlJw/hIX1wOo1WOknTXLvnJKO
         JyeQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxaUiTyLgW8gDCIEyOpvn0HTzXlEqJITgQJHcq7HNYvo3SCS4k6GuXOXsUNziioWUdy8G0+d1WD5+cSZY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9k7VzsspGv9obUfnve45/IYGzIah1Q81Q9NwPeYanULMwvnN6v
	T4IPPlrnluaUJcKGe/X68M95+YzFXMXt1LV3Q7itwaTxeQWwArRWhwfON9qIQgQ1waKRLsuYo2L
	0FHqGIkT9+yjnLeXgqwNC+9tuB/lGNLT+kllBETuSxtNi1mz0Iog69E/IOCQhjsc9o8cN
X-Gm-Gg: AYBFou0dFoEjSiHGE6YRn0boSewkCaTS4lZxFZ0zlhabHoXjyuR1fvrVg+/fRM3zply
	rt9AmNRZkzHmBkjNINSzQGpJUf2IdVbxk0egqrQ6jbEJJAZDrzGrPnFfp2R0IFM0RaAvvZhTbdU
	XdyBc76di72ZiGaTg7oxV9K18apQdy92MSnSb4tzFfwICn4jr2dd5QUPhJuLcDeuWu+oi2qq00c
	ExwyYRyzYgt6CO728IqStKk3AuOP+Xr7s9qAmkpbcDJfDHWpf5V+PoPWCPi4JKi5GDdapNTNmUH
	T6VJS6NHToiZFFKIHM2hR3ANcpOevQV5zSP3wrcJ6Y6LqrQWTA2Vm5xPdJ9pB7HVdhJOayxqqFQ
	iY5dx4Ts9SLdcoqqkRmPOPow/rysmDzD8s/UvDnmt6lkTwSaWeT72bR9D3VqwUFFm7rh1oFdeG9
	03
X-Received: by 2002:a05:6102:5243:b0:7cc:115:ddf4 with SMTP id ada2fe7eead31-7d072cafbdamr8260486137.25.1793869992557;
        Thu, 05 Nov 2026 01:13:12 -0800 (PST)
X-Received: by 2002:a05:6102:5243:b0:7cc:115:ddf4 with SMTP id ada2fe7eead31-7d072cafbdamr8260470137.25.1793869992117;
        Thu, 05 Nov 2026 01:13:12 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea18175bsm8523052f8f.7.2026.11.05.01.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 01:13:11 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Aaron Antone <aae@amazon.com>
Subject: Re: [PATCH 0/2] gpio: aspeed: Fix lost interrupts from write-1-to-clear status bits
Date: Thu,  5 Nov 2026 10:13:09 +0100
Message-ID: <179386998646.14190.12898260042958043905.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104-gpio-aspeed-irq-status-v1-0-9805645f856d@aspeedtech.com>
References: <20261104-gpio-aspeed-irq-status-v1-0-9805645f856d@aspeedtech.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzNiBTYWx0ZWRfX43F9n4kihto1
 TgpbSovXTyw0OEYzhzysl/ffDADDWV8ptIuB0FEq12X4gm4oIYg4/ffBamxoYwcVpWsv8w29TJN
 Af+MlMZEV3v1ixKbIoK4EV/zbg4yYpggWOOUdkr8/O51YQv+pbQbTQzny1KoL2maF3CVJIUtsvF
 kzhsp+xw4KHI2GCu67w+SrzHfeh/sBEFVn0bgktlwE1NeFeJweTZXaeMplfHZ2q8l8323hrkdH1
 DV8ZWUIADX397o8AGEh1+tXxeBsbs2LxfHPzNYDa8/JpZFI1XTgCnJTk+MwtctKX6oGQsJeKMQx
 0lAF7ZqGa7rMu+fYWkcwgt9L9ogWLuL+iik/HIB9l+ZBenx8IGscfcL2mxh9v9ozrwP/j6PAsL6
 0D3YFp8CqQD9ObucPA36H3Od5VFv+qwU2BXOUMeegGg0a/KiX/biV0UJe8LrdOMwK7hHmaEacgr
 1HYOICLVNQXNZ3xbv5A==
X-Proofpoint-GUID: ABaGojP5IoU1YJyIfYnpc6XR8m-GUSan
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzNiBTYWx0ZWRfX0cQ8nHkcOoaj
 fk5U4+AqJAvMtPoMiEFufKNKvXerWlv99o5wDW/eRocltsSeroBL0zJdOTITgXZTeHguMW0tHJD
 rbZ5fFFy/yiVzAb4G/1r0qGFoU1Gy30=
X-Proofpoint-ORIG-GUID: ABaGojP5IoU1YJyIfYnpc6XR8m-GUSan
X-Authority-Analysis: v=2.4 cv=WOXqzXsR c=1 sm=1 tr=0 ts=6aec48a9 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=voHqOY2aTaljLMbC2lEA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050036
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Wed, 04 Nov 2026 11:58:34 +0800, Billy Tsai wrote:
> The Aspeed GPIO interrupt status bits are write-1-to-clear on every
> generation, but the driver updates them with read-modify-write helpers
> that write a pending status bit back as 1. Each write therefore clears
> interrupts that have not been handled yet.
> 
> Patch 1 fixes G4 (AST2400/AST2500/AST2600), where the status register
> covers a 32-line bank. Acking one line clears every interrupt pending
> in the bank, and an edge that latches after the handler has read the
> status register is lost. This was observed on an AST2600 BMC with two
> lines of the same bank toggling together at host power-off.
> 
> [...]

Applied, thanks!

[1/2] gpio: aspeed: Clear only the acked line's G4 interrupt status
      https://git.kernel.org/brgl/c/5d362564bd2982def7e80d7f1e756a97440c7adb
[2/2] gpio: aspeed: Preserve the pending G7 interrupt status on control writes
      https://git.kernel.org/brgl/c/18cc1d1ad94df8a6760fff2617d3d6923550cba0

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

