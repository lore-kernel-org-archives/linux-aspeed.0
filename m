Return-Path: <linux-aspeed+bounces-3223-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20459D3B7E5
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Dec 2025 01:50:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dffLz4XXjz2xKh;
	Mon, 29 Dec 2025 12:50:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766424311;
	cv=none; b=c9GJ8ndHSkZ/XKU+W6e2NK5sZyOQTHLX1nF0l1WBJB3tIvAG+9EDbSdOJsOZ7VnrMxPiC0Q2+GPm2VCPU1uZQLepXEyx7BGfuaN3ZeWz+2qplO3E814r5nl8ioiHfG+gCMSRvwrZAfxOUdY5UdV3PH/KrJvF+FbC/MYuT8xWeI4aDqrZAEAzfmmVbkm5PWXmwFsCTlWhLqFU2v5bXiPAkoPECKRFPIIIHTztzfwgm+I0isUAC+xAY2AvTxwXPZY2BBgFNCZkwnMq7kbTajV3M67kIorYg2nUdbm9R/LGv7Y9wNFW9/BIl0Evdnc8dYkb0ggGDE34KKo1uuU5Atr2vA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766424311; c=relaxed/relaxed;
	bh=UJ0a5V29viz7LLXs2uuLzoheftdEXYHQbwbfYUs9794=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0s/5zYXT6jJ2jzfxsFgU3eIQe50Iqui4eriM3Ah0KMcIpwdy0RJq98nmUmc95t712+Rz/wrM9kyquHH1jlikBqRvJyKTIQJv5sybfH2S++l0lRvyVCdq8dPkbkd017BVw62C+qz3TqcxkOVb9yTVQl7zCjEhEn8jfJGNRsI6laYcMI+q8S4i7QkuZEiKcCgMt6Iny9FHkqsDUzEhafxbjOSWgQXp8hQOLah4BR9szFoq4XqPUIW4sAHMBcS2FhfeUz4C+tPeVO5d/zo6S/wn4l3IjfQWAODAubSgqBxjiAzLGiNLSi1kIhlPKAN8YqAozBl1H40rYyS3QQ6pbElfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RflW7gzB; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MFhPEtf4; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RflW7gzB;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MFhPEtf4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1636 seconds by postgrey-1.37 at boromir; Tue, 23 Dec 2025 04:25:09 AEDT
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZlQF2FvCz2xHW
	for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Dec 2025 04:25:08 +1100 (AEDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BMEC1eh1568831
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Dec 2025 16:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UJ0a5V29viz7LLXs2uuLzoheftdEXYHQbwbfYUs9794=; b=RflW7gzBBE8Aopcg
	DvCZI7IbiXVCNW7maGoHbDhOPdXXItEJS9JKBKx7VvZHYApwi8PyGEHIrOfw/U40
	WTFTIgxbc8I5gTkf1znhAyzipdBmzkm7BLCZU7Ia17gpDq1fNX6w4hi1sYq5oZ9v
	KAUY4EIkc50QyzENxOJHqGuS6l2TtX1xyT3cV78jFcQDmfwZp3xLeKdfCahJ66bS
	7H5J1I0SB56FwdK3be11GexQ0N09AhnbXOQzzMKxYEXg/gYIiK1UHUkHJsZJKAfR
	fXSWl11t9AWcz+AFXpXbPwjhmLe9PMk4oZfwdOoUzxyh7R0T32up9wAZl2sKDd39
	2mgbVg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b76yy0j9j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Dec 2025 16:57:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4f1d7ac8339so136241871cf.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Dec 2025 08:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766422667; x=1767027467; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJ0a5V29viz7LLXs2uuLzoheftdEXYHQbwbfYUs9794=;
        b=MFhPEtf4nPBd+OjT4194giyxC1uzUwMYFtCuWFTdozwx0HDXXPOpmlh1MonvrPM/lo
         f7b6x//qCGAD2VPovCvUsKTLX22ebbnDGZ5A6HGMBJJ5JNdS3vPIgLScm095vmzTWeAw
         YV65A1Fzmej7FGa0I6i6cs6+OEKwL2MvgIWfV7lwUcmlBOmrX5S2NPk99JNyi/bW5LM6
         BB88gVf6NSJEAkG9SrXZx58m344HxqfmXw2keOuzOpVgCL6k7ExTRS1HxvwrB0Xg+Nub
         /nfEOKb0z6r0K7JnPeSg5Ig16DUN9w+DRDxE0Vqav+7AcEm7lbfZK47AOds6qy6bYJg1
         2HCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766422667; x=1767027467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UJ0a5V29viz7LLXs2uuLzoheftdEXYHQbwbfYUs9794=;
        b=c9byLbu40e0zHs/nfSg9rfY9FjTOlgHbuZDVg6Bz3QoVdg/fa4VKTFzk3zZeWCPzu1
         OPOYdqqZCR7HMt0o/HjDQieSLO+lbWlt/aWRIXeCvpgXsLwMnWk9+0NHwtB6i3HxwTkR
         Bne4bMKDof4y7tBX86fBRa7pVD2fCerFyccjUxbkEaHamvz1mFdnpRGfnFrXe+RM2S7s
         OeVvr4abQjorMNMVD3MD1KaKWvbebOioAhs2e5LyfGgpOZalHrnVinXfYu/plH8lvGXa
         hin+BjBKY19nbEnc1RzVvX98ACnOWEgkm5HfRt5WXgl7XQih84dnIZUsuaaIGrBgFlSe
         2E9A==
X-Forwarded-Encrypted: i=1; AJvYcCVM6hD5yerPidiuVzByD3SXY/cPaQyCESpvBOlRuEuJkz9NuF5ZIvQlyXVQqq2goSSzQ/qkjH8TFk2fLhU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz8Al2WctWwXvUmQbQB4QMn9c3NvY/B8ttdhfxiBKCwh1v83ZOp
	Oeo5H4mkcllhvWl4FxSg8TkJhE957fUwDWoTVqxWYKx5d+y17yBlmyTGkm/8k7r3OrBS5es8Uys
	TnsUeOhWoAP3a8sk1y7bezSgCKbBblzmu498YwFdwSQU2RXbNDAEVtcHfxkZnFwZlwNxE
X-Gm-Gg: AY/fxX7+pe6v4tdC8uBhQff6+UBsL36BupooxFA8Fg6RGiLR9iRlKXTz64LT+e/w4Jv
	AGpOTQat/AQ8Hlsiwu7tGGHrfvn09rJbjn/ZSzob5R7nFqTHpe31cdNSjofaK5AI/N7rzfCGX/I
	btXhh5xP9BDwgQHqT/ENZqozD9wE3BNWKV+BpmuhQMs0jvD3LLWgrBe7TRtRTHsFZhdl2fVPi9Y
	DEWuI/SAVpEqLp7NNBPRDp3wZq5nXwLNNXwdr5Beichki6A78GJkBkKqwFXDCQ8AGHCbZ0CC0Nq
	vfES8aVAPbIp+ZLUvtH05wPU6ix7V7sDyDy2BhoDgw+RPhbv8dSXk6n+w8rW6crKUq0qzWrZe2H
	NEuiW0AUjiO1tsfRV2bCMWqwytaj9qri8ESfEu9s=
X-Received: by 2002:ac8:5812:0:b0:4ee:19d6:fadd with SMTP id d75a77b69052e-4f4abcb5a4dmr178429461cf.4.1766422667677;
        Mon, 22 Dec 2025 08:57:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWZF599NsIynd91SWFwhgXiDj4KAvOYt3rbwctNuUe4W1B3LixKxYkgSgS3/cdAjsy77Bt2g==
X-Received: by 2002:ac8:5812:0:b0:4ee:19d6:fadd with SMTP id d75a77b69052e-4f4abcb5a4dmr178429141cf.4.1766422667183;
        Mon, 22 Dec 2025 08:57:47 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:3452:ec03:2e24:c9a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193621c8sm197464795e9.7.2025.12.22.08.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 08:57:46 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linus.walleij@linaro.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v3 0/3] gpio: Simplify with device_get_match_data()
Date: Mon, 22 Dec 2025 17:57:44 +0100
Message-ID: <176642266266.42223.9755579914845515277.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251219-gpio-of-match-v3-0-6b84194a02a8@oss.qualcomm.com>
References: <20251219-gpio-of-match-v3-0-6b84194a02a8@oss.qualcomm.com>
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
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDE1NSBTYWx0ZWRfX4vM5KQ0ILEqQ
 uUO1BGRchhhfbKG+WEvRZ48PIcs+DVDcK7owq/5XmiqGNfnD9cEqcYDWwTIfGpOjPzYNZ3mranu
 8kTWyEEwZDT2fvn6ny74SeTd4F3Imjy7LIdz7PsXFBcXVoENcvubXiOS8Ov/STitLbWfWr6DMqh
 659N/E3noqg8WXFKHiU1cqxLnHkH3ZYIKHBX4ePrkTnsxje9VBs33X4HLBNpVGBZ4g+vSyNyPSt
 jf2O4IYVevpRwXAWx/jkZpTrLYO/AcTuYfOr9nsjXySAZDaDPKT1s4KP2mpoxbX8OTQTb3lg4eb
 xATNsXKRuxM8svrAhRMiwq7k/nf3oSYkdTrNjZZRvAKqYQ7/fzfR22Vqyz6xbMMjiRY66xtWSwa
 5UPA8B+8pzXKPZf/KCUkX3e3gEPvGdQ+dY3zsV3tua3tsdijAHayzkSFIsfxyxS639WuXOSpLJd
 9nCZ4kC/tv5TzrY4TUQ==
X-Authority-Analysis: v=2.4 cv=Zb0Q98VA c=1 sm=1 tr=0 ts=6949788c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=BSbm5AsyGp5ZQscXBokA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 8bLpm6Od8SepCvXbO-NraoR17-4W3yKA
X-Proofpoint-GUID: 8bLpm6Od8SepCvXbO-NraoR17-4W3yKA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-22_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512220155


On Fri, 19 Dec 2025 13:13:11 +0100, Krzysztof Kozlowski wrote:
> Changes in v3:
> - Fix subjects and commit msg -> device_get_match_data
> - Patch #3: Use dev_err_probe
> - Link to v2: https://patch.msgid.link/20251219-gpio-of-match-v2-0-5c65cbb513ac@oss.qualcomm.com
> 
> Changes in v2:
> - Drop applied patch
> - Use device_get_match_data() as suggested by Bartosz
> - Link to v1: https://patch.msgid.link/20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org
> 
> [...]

Applied, thanks!

[1/3] gpio: aspeed: Simplify with device_get_match_data()
      commit: cecf10b700e06a2f2e2b638b1f680e1ae7f343ac
[2/3] gpio: creg-snps: Simplify with device_get_match_data()
      commit: da7c18a457c7a32c4ed1e1e326837d9d7cb4483c
[3/3] gpio: zynq: Simplify with device_get_match_data()
      commit: 48befae0d6eee275c3e30d1cd45f39d6ba011e19

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

