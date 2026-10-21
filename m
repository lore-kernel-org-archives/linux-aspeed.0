Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94441606A31D
	for <linux-aspeed@archiver.kernel.org>; Fri, 23 Oct 2026 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ahXk7078;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KWr9kOEu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9kFq1rkgz2yLY;
	Fri, 23 Oct 2026 11:21:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792575888;
	cv=none; b=KDW6s0ZGHSMaIA6zlGy2Xj9pJSmw5N8FUHh4tguhOS0abRfgYKtiAshkcMMfkVzO3iDWL9sN3rZ/0QaVRCmpejHOL7Zamu23J++wMu7i6f8LJhNLbVVu5B7YPT6tOZdAMwXinA3UjTNMM5ApefwNz8C7ZAY4WSoapuvGZmTm+yNx/JZRUN6WYk5mELv7n3QutXp8yqqRtw7V2e0a40AmL5KdkFPFd93RdQIY/mILMwmCc3WDI3Jfow5APWpNUHoUngsEvA4wSukGJyj+o/g2M7CC7cHn7IjOcAybIeG+y4SkjH/v8+AmWWfIUfZhrHYbOT34eUWtMfr07XPiRI8Nxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792575888; c=relaxed/relaxed;
	bh=ZICGnoDUzzWlAQIxspOsX/uJiYZvuNvYB+Jhm0X2C4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhXZlszSZG/PN8UasxLYq0ueJ35ZKv/pHAwkZ98ECC27S4uidWU4vPt4z2A/PTB7cW0oRkiCudKglB/zjrPrUYV5twQ93MQ9DvWySpnRpP9jAG+DTfE+sUPUQ0nPfvKzAry9wsEvL0RO+kInvv/sg9SUnHJRFcb2K/THCWDYnhXGrL8/LajLq3ypig8npngB9BDElgLJ/DrgCiY872YoP3fd1SCyxMGb5Iu7k5SxVnifa05ppbLw/mW1T/HqtJQBavWdiHuAtfjGtVwfFdcXkRrviY/Zz7J3P++QsXo6OYjRfJ1xw8O3sS6nLhycwA7ReQydX5Wcoz0ltwJHkZZZcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ahXk7078; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KWr9kOEu; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=konrad.dybcio@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ahXk7078;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KWr9kOEu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=konrad.dybcio@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8ksB0s45z2xPW
	for <linux-aspeed@lists.ozlabs.org>; Wed, 21 Oct 2026 20:44:45 +1100 (AEDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L5j2vI3355908
	for <linux-aspeed@lists.ozlabs.org>; Wed, 21 Oct 2026 09:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZICGnoDUzzWlAQIxspOsX/uJiYZvuNvYB+Jhm0X2C4U=; b=ahXk7078Eg6/b5Ya
	BEW6RV60mcxyAc3S+r/XwNQA8a5FhN9ioUdntl5Hh2qEPJaAB6KJuZlvz+rwprEr
	g9xvPfooth56P+Qs5KIVFP2xPsqNgZwEUq5snCTWrGa5e0dF2G6yPPYDAGQItnKg
	81trmTb8mz34C1Dmny8QhvNV3lb85iZ+kxmKXeA2I2S6OZ3yk9DIxFvB+qojIotU
	Z48gmHMqxhI7tsRmT7aDo5PSGmiAvuftosIIImUw7c6r+js6IcXjgqXE20fKdRBV
	4WH7b66ZvGpz36jOQ+09QSNZX1NusCJY5yu+W3FdP3QLkRHhpjiCi4AfJHXpISgh
	DhIygQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda0ka3r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 21 Oct 2026 09:44:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cc50fb0d2so8498585a.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 21 Oct 2026 02:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792575881; x=1793180681; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZICGnoDUzzWlAQIxspOsX/uJiYZvuNvYB+Jhm0X2C4U=;
        b=KWr9kOEuWaCiNVmPo8H+HJR4hSu8ikgG8waA7QqFRU89vxZeVxp/JhyX6EwfrUcgk0
         YE7a4Ck+tkeesfWNjn/SFGvgd57VYiW4rjvS2FoGondGAXZWd00UdBexJaIaeiJb+Kgc
         //eb3izG0qPDHzgvV6F6Bb9imGvB8/LIQOSl/eQeeWDoYvVX+gQVqrOKbJ76Ylq5xFeK
         ynNoh92oQbRC7WbLHXvQsRys+/duWSbJBGex726GJef/3UBIUhMNOd2/5nekzdL9MDjQ
         nRitZIl0PQ8jPivn5drsh9rmluq941EAo1DGLhzCF3et/mUXIWp3c7NsO9KFBmmzlvDS
         lq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792575881; x=1793180681;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZICGnoDUzzWlAQIxspOsX/uJiYZvuNvYB+Jhm0X2C4U=;
        b=SU/4MTjlmtOi+NZsM42SftmK84DA6Srvt2GwrnJHt4FBvf5NkK8Cb72G/YIMGeO6ry
         ciFrAbuDsxrWfBJsdnjMpA6fCRXppHzQtGJevZpJFCuCROC2rqlRyx3aFqiyCDqywn1j
         i7YkLcfVAV6MZlj6e5xi30335YKv7nup9A3G91J0KnXn11fzKgsjcBNlAAT1I51OM9Bm
         dbJHuLcKy6ULALpm9trop0Hg4+neqZT0/LTGs+XeGirUioYNin1W/2wbFK4uc8QcGhCV
         6YjhXzHbr1Sl0TJQVluEd5na8P7+YM2lQ0yRhW/SvY94+QGBzM+ckm0WGVduh1jQWu5C
         bX1w==
X-Forwarded-Encrypted: i=1; AKwUvBwk9T6FNln/k1cJD/kNbmY1nfX+EIMlYnrjIzTa/PlH+GiqehQjeyvT/g7YZmbuDYVSzd0c0Sz3BlS42wc=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI11c+A3ugc5UN1YPvFm7JqNKhC5b46jY2aK/E4fqbDwM2/84Yf
	KSXppE6c2zEGEjyYerWYelQZYvm/JI5IxMGZqFGPKxoS3+aPdboQjUl5Wng8YGxU5rdYRZRzbUt
	qi5R/tPFIsVAbsyQBD8ISYypUUr+pYeBUEzeLebhIbvnu7bMe5JxS0KeBryNyeTOS9SBh
X-Gm-Gg: AYBFou1x2ClAXtzWsHtx8WxPXH18ffwxKx+BcY3khRNmH0/kd8yLnb/e6ryPYbiLc0Y
	drLpdwz1dcjuZ5MQfW/kYAHCt9k/cMbrQb+nIPHkvIDUsdO8QbRGJvZPXw3wvZBzrBxNMp0edPB
	HCoUyYtJjMdkdaGP61GfYqEQZkkC73YJVJunR5p/pGSN0y8h2V1nXCoMdmh9NJUW4rqhKAxLbKO
	nfrVT+09k3O4xyL3UpQO2pS7VCCbCRtIWYaqzzVzUuIN68F5BRnba2fOajpgCeIR4ZfrA6wbfgs
	NNgJ/3AOTZUBaqzJfqC4hKeWLKsKkqZPbaK1ErZW01q8GBIqH9htxCmLpeuY7jyaCKVt5pZebE4
	0uAMEco+w50yWk9NFSWfjTQ==
X-Received: by 2002:a05:620a:4511:b0:93e:6d87:4f69 with SMTP id af79cd13be357-93f57f3bf10mr367398085a.3.1792575880978;
        Wed, 21 Oct 2026 02:44:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4511:b0:93e:6d87:4f69 with SMTP id af79cd13be357-93f57f3bf10mr367390585a.3.1792575880494;
        Wed, 21 Oct 2026 02:44:40 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4678f7cc2csm59794166b.24.2026.10.21.02.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 02:44:39 -0700 (PDT)
Message-ID: <8ceba969-91d2-4b43-81d0-b26e7139664b@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 11:44:31 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: usb: snps,dwc3: Fix downstream port
 numbering
To: Chen-Yu Tsai <wenst@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
        Neal Gompa <neal@gompa.dev>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai
 <billy_tsai@aspeedtech.com>,
        Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Peter Griffin
 <peter.griffin@linaro.org>,
        =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, Yixun Lan <dlan@kernel.org>,
        Troy Mitchell <troy.mitchell@linux.spacemit.com>,
        Minda Chen <minda.chen@starfivetech.com>,
        Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Wei Yang <yangwei1@eswincomputing.com>,
        Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
        Hang Cao <caohang@eswincomputing.com>, Li Jun <jun.li@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Roy Luo <royluo@google.com>,
        Yang Xiwen <forbidden405@foxmail.com>,
        Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Robert Marko <robert.marko@sartura.hr>, Xu Yang <xu.yang_2@nxp.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Stanley Chang <stanley_chang@realtek.com>,
        Ze Huang <huang.ze@linux.dev>, Aswath Govindraju <a-govindraju@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-aspeed@lists.ozlabs.org,
        imx@lists.linux.dev, linux-samsung-soc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
        Mathias Nyman <mathias.nyman@intel.com>
References: <20261014082037.1774672-1-wenst@chromium.org>
 <20261014082037.1774672-3-wenst@chromium.org>
 <7020a7a6-332e-4fd0-a659-d82eb768614c@linaro.org>
 <CAGXv+5G1kgyumbj7wGf6rPFbg3spSO0zYmEkn-hZT4qUdJbytA@mail.gmail.com>
 <03375a31-0ac6-47a4-b0dc-6327080e1622@linaro.org>
 <b4c0761b-34f2-42ad-97e7-ab34ae776281@oss.qualcomm.com>
 <8d4d3ec2-3c97-4a46-97f8-048fdf81b853@linaro.org>
 <CAGXv+5G_ig=k-eH8Cp0ES70WxTHcBS2TVj9VmHaG9caROiAuQQ@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAGXv+5G_ig=k-eH8Cp0ES70WxTHcBS2TVj9VmHaG9caROiAuQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzOCBTYWx0ZWRfX9bk3G1VEtDdG
 h8YzT2Od5PHbCtQg8unOEEfw7paMvSm5gYvptzOA7q1LDD42KqtnPIlE0uZmKdmrO+8q0FJZjS4
 677klCLtvVCPolt8UlrznzRyibRNACbC5S57TGdcbSKswQSRMHBAR7T9Qv2iAPzNGCWEUoiU8Y5
 Sz9+l3p0f5BPueckOBen5JRoXnO/2eWdXdfKkcvNX1yfrdFPTeDOzmH0Uw9OA6s79RqCX7hzPne
 Mz9Ql4BBhh58/tSDMqN5S16k9AC6tN9PFGmB4qXn+L0RQQ8gf5olBY7Et6hfr8m4XSMRNVRNX3Y
 50VK913VDLcwQ9yx7tC4wFpI+b5O9ui+zB50C9j7jrEkj+Pkw07CA582urbBwxM9H6xK9Wzs9GC
 bbuBV0KQuaDyPAJi/cGV3n0qiuFK4SeTgKTWEENb3B0x7PqKaTi4OY/crR3p1J53hR6eFehzvk9
 bLHUEl9vn9LTc3VKEkA==
X-Proofpoint-ORIG-GUID: h355oFOI3V2kcc9oSuaB6BZEO44lZpRU
X-Proofpoint-GUID: h355oFOI3V2kcc9oSuaB6BZEO44lZpRU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzOCBTYWx0ZWRfXxR+Lkj+pRQjk
 2mptTNAX5cPUanXNrZnx5hHKy7d5jQq3lo7hO7GS/jZp/H5ixD0JDwamUZtCAkQ/AivLme+uT/Q
 YqJWuYJAmMToaeF4esmncHGw+nM1ro4=
X-Authority-Analysis: v=2.4 cv=HL5WhYtv c=1 sm=1 tr=0 ts=6ad8898a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=iuaGvn3fa_lUOTDqeYoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210038
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/15/26 11:00 AM, Chen-Yu Tsai wrote:
> (Cc-ed Mathias, the xHCI driver maintainer in case I misunderstood xHCI.)
> 
> On Thu, Oct 15, 2026 at 4:44 PM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
>>
>> On 10/14/26 18:36, Konrad Dybcio wrote:
>>> On 10/14/26 11:44 AM, Neil Armstrong wrote:
>>>> On 10/14/26 11:29, Chen-Yu Tsai wrote:
>>>>> On Wed, Oct 14, 2026 at 5:28 PM Neil Armstrong
>>>>> <neil.armstrong@linaro.org> wrote:

[...]


>> How about the USB4, does it use the USB3.0 port ?
> 
> I'm not familiar with USB4. A quick search says that it can tunnel
> USB 3.x, DP, and PCIe, and it doesn't have its own USB HCI defined.
> 
> So I'm thinking the USB4 controller would be more like a nexus node
> or multiplexing node, or perhaps like a USB C connector. It has input
> ports for all the protocols it can tunnel, connected to their respective
> controllers (XHCI, DP, PCIe). The binding probably would be very messy
> if one controller supported multiple outgoing ports, as each downstream
> port has a 3-to-1 relationship with its respective upstream protocol
> interfaces.

Yeah that is more or less it.

There needs to be a connection between the USB4 router and the native
(USB3 *port*, not hub | PCIe *port*, not RC | DPTX) protocol adapter
where the tunneled packets end up at to create a PM devlink between it
and the USB4 router.

ACPI does that by adding a `usb4-host-interface = &reference_to_router`
property, for DT that's still undecided:

https://github.com/devicetree-org/dt-schema/pull/196

As far as the Qualcomm implementation goes, I was hoping we could
go forward with base1 numbering as the DWC3 is an XHCI controller:

https://lore.kernel.org/linux-usb/20260929-topic-dwc3_tunneling_state-v4-0-63e296346d57@oss.qualcomm.com/

Konrad

